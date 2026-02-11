# docker-solana

> A Docker container for the **Solana CLI** and **spl-token** — easily manage your Solana coins and tokens without installing anything locally.

### Build Status & Stats

[![Build Status](https://img.shields.io/github/actions/workflow/status/andreaskasper/docker-solana/docker-image.yml?branch=main&label=Docker%20Image%20CI)](https://hub.docker.com/r/andreaskasper/solana)
![Image Size](https://img.shields.io/docker/image-size/andreaskasper/solana/cli)
![Docker Pulls](https://img.shields.io/docker/pulls/andreaskasper/solana.svg)
![GitHub Issues](https://img.shields.io/github/issues/andreaskasper/docker-solana.svg)
![Last Commit](https://img.shields.io/github/last-commit/andreaskasper/docker-solana.svg)
![Commit Activity](https://img.shields.io/github/commit-activity/m/andreaskasper/docker-solana.svg)

---

### Features

- [x] Solana CLI (`solana`) in a container — no local installation needed
- [x] SPL Token CLI (`spl-token`) for managing tokens
- [x] Easy wallet mounting via Docker volumes
- [x] Weekly automated rebuilds (Debian security patches + dependency updates)
- [x] Build ARG for pinning a specific Solana version

> **Note:** This image uses the [Agave](https://github.com/anza-xyz/agave) installer — the actively maintained fork of `solana-labs/solana`, which was archived in January 2025. The CLI tool names (`solana`, `solana-keygen`, `spl-token`) remain unchanged.

---

### Video Tutorial

How to create a token/coin:

[![Create a Solana Token](https://img.youtube.com/vi/befUVytFC80/0.jpg)](https://www.youtube.com/watch?v=befUVytFC80)

---

### Quick Start

#### Create a new Solana Wallet

```sh
docker run -it --rm andreaskasper/solana:cli solana-keygen new
```

> ⚠️ Write down your seed phrase and store it safely! Without it, you cannot recover your wallet.

#### Check your Balance

```sh
docker run -it --rm \
  -v ${PWD}/id.json:/root/.config/solana/id.json:ro \
  andreaskasper/solana:cli solana balance
```

#### Work with SPL Tokens

```sh
# List all token accounts
docker run -it --rm \
  -v ${PWD}/id.json:/root/.config/solana/id.json:ro \
  andreaskasper/solana:cli spl-token accounts

# Create a new token
docker run -it --rm \
  -v ${PWD}/id.json:/root/.config/solana/id.json:ro \
  andreaskasper/solana:cli spl-token create-token
```

#### Interactive Shell (debugging / advanced use)

```sh
docker run -it --rm \
  -v ${PWD}/id.json:/root/.config/solana/id.json:ro \
  andreaskasper/solana:cli bash
```

---

### Docker Compose

A convenient way to run repeated commands with a persistent wallet:

```yaml
version: "3.8"

services:
  solana:
    image: andreaskasper/solana:cli
    # Mount your wallet file (read-only is recommended for safety)
    volumes:
      - ./id.json:/root/.config/solana/id.json:ro
    # Default command — override when running: docker compose run solana balance
    command: ["--help"]
```

**Usage:**
```sh
# Show help
docker compose run --rm solana --help

# Check balance
docker compose run --rm solana balance

# SPL token accounts
docker compose run --rm solana spl-token accounts
```

---

### Building with a custom Solana version

The Solana version is controlled via a build argument, making upgrades easy:

```sh
# Build with a specific version
docker build --build-arg SOLANA_VERSION=v2.1.21 -t mysolana:cli src/

# Or the latest stable (check https://github.com/anza-xyz/agave/releases)
docker build --build-arg SOLANA_VERSION=v3.1.8 -t mysolana:cli src/
```

---

### Environment Variables

| Variable | Description | Default |
|---|---|---|
| *(none yet)* | *Planned for future releases* | — |

### Important Paths

| Path | Description |
|---|---|
| `/root/.config/solana/id.json` | Wallet keypair file |
| `/root/.local/share/solana/install/active_release/bin` | Solana CLI binaries |

---

### Roadmap

- [x] Basic Solana CLI image
- [x] SPL Token CLI
- [x] Automated weekly CI rebuilds
- [x] Versioned build ARG (`SOLANA_VERSION`)
- [x] GitHub Actions layer cache (faster CI builds)
- [x] QEMU + Buildx setup for future multi-arch support
- [x] Docker Compose example
- [ ] Environment variable support (e.g. `SOLANA_NETWORK`, `SOLANA_URL`)
- [ ] Automatic version bump PRs via Dependabot / Renovate
- [ ] linux/arm64 support (requires Agave arm64 binaries or source build)
- [ ] Build tests (verify `solana --version` and `spl-token --version` output)

---

### Links

- [🐋 Docker Hub](https://hub.docker.com/r/andreaskasper/solana)
- [⚙️ Agave (Solana CLI fork)](https://github.com/anza-xyz/agave)
- [📦 spl-token-cli on crates.io](https://crates.io/crates/spl-token-cli)

---

### Support the project 🛠️

[![donate via Solana](https://img.shields.io/badge/Solana-CPeKEKhitSeZt21Hir5vfvSnKbH3XCJpAUUfneL3WgZV-green.svg)](solana:CPeKEKhitSeZt21Hir5vfvSnKbH3XCJpAUUfneL3WgZV)
[![donate via Patreon](https://img.shields.io/badge/Donate-Patreon-green.svg)](https://www.patreon.com/AndreasKasper)
[![donate via PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/AndreasKasper)
