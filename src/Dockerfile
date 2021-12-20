FROM debian:stable
RUN apt-get update \
    && apt-get install -y curl \
    && sh -c "$(curl -sSfL https://release.solana.com/v1.8.5/install)" \
    && export PATH="/root/.local/share/solana/install/active_release/bin:$PATH" \
    && apt-get -y clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod 0777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
