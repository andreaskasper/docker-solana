FROM debian:stable

LABEL maintainer="Andreas Kasper <andreas.kasper@goo1.de>"

RUN apt-get update \
    && apt-get install -y curl libudev-dev libssl-dev pkg-config build-essential \
    && sh -c "$(curl -sSfL https://release.solana.com/v1.8.5/install)" \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && export PATH="/root/.local/share/solana/install/active_release/bin:/root/.cargo/bin:$PATH" \
    && cargo install spl-token-cli \
    && apt-get -y clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod 0777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
