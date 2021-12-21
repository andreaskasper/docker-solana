#!/bin/bash

#if [ -d "/wallet/" ]; then
#    if [ -f "/wallet/id.json" ]; then
#    fi
#else
#
#fi

if [ -f "/root/.config/solana/id.json" ]; then
    echo ""
else
    echo "************************"
    echo "please be sure to save your wallet example:"
    echo "-v /safe/id.json:/root/.config/solana/id.json"
    echo "************************"
fi

export PATH="/root/.local/share/solana/install/active_release/bin:$PATH" \

case "$1" in
    bash)
        bash
        ;;
    solana-keygen | spl-token | solana)
        exec "$@"
        ;;
    spl-token)
        exec "$@"
        ;;
    *)
        solana $@
        ;;
esac
