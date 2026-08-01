FROM debian:stable

# ─── BUILD ARGUMENTS ─────────────────────────────────────────────────────────
# Solana CLI version to install. Agave (the maintained fork) follows the same
# versioning as solana-labs/solana did. Latest stable: v2.1.21
# Override at build time: docker build --build-arg SOLANA_VERSION=v2.1.21 .
# See releases: https://github.com/anza-xyz/agave/releases
ARG SOLANA_VERSION=v2.1.21

# ─── IMAGE METADATA (OCI labels) ─────────────────────────────────────────────
LABEL maintainer="Andreas Kasper <andreas.kasper@goo1.de>"
LABEL org.opencontainers.image.title="docker-solana"
LABEL org.opencontainers.image.description="Solana CLI and spl-token CLI in a Docker container"
LABEL org.opencontainers.image.source="https://github.com/andreaskasper/docker-solana"
LABEL org.opencontainers.image.licenses="MIT"

# ─── SYSTEM DEPENDENCIES ─────────────────────────────────────────────────────
# libudev-dev, libssl-dev, pkg-config, build-essential are required by
# both the Solana installer and cargo (for compiling spl-token-cli from source).
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        libudev-dev \
        libssl-dev \
        pkg-config \
        build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ─── SOLANA CLI (via Agave) ───────────────────────────────────────────────────
# Note: solana-labs/solana was archived in January 2025.
# The active, maintained fork is anza-xyz/agave (https://github.com/anza-xyz/agave).
# The installer URL changed from release.solana.com → release.anza.xyz.
# The CLI binary names (solana, solana-keygen, spl-token) remain unchanged.
RUN sh -c "$(curl -sSfL https://release.anza.xyz/${SOLANA_VERSION}/install)"

# ─── RUST + SPL-TOKEN-CLI ────────────────────────────────────────────────────
# spl-token-cli must be compiled from source via cargo.
# After install, remove the cargo registry/git cache to keep the image lean.
# --locked is not optional here. spl-token-cli ships a Cargo.lock, and that
# lock holds a delicate balance: solana-address pulls wincode 0.5.3 while
# solana-hash, solana-signature and the agave-* crates pull wincode 0.4.9.
# Two versions of the same crate coexist on purpose, and the trait impls line
# up only for that exact combination. Without --locked, cargo re-resolves to
# whatever is newest and semver-compatible, the alignment breaks, and the
# build dies with "the trait bound `RewardType: wincode::SchemaRead` is not
# satisfied" - which is a diamond-dependency mismatch wearing the mask of a
# compiler error. This is what broke the image between April and August 2026.
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && export PATH="/root/.cargo/bin:/root/.local/share/solana/install/active_release/bin:$PATH" \
    && cargo install spl-token-cli --locked \
    && rm -rf /root/.cargo/registry /root/.cargo/git

# ─── ENTRYPOINT ──────────────────────────────────────────────────────────────
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
# Default: show help if no command is passed
CMD ["--help"]
