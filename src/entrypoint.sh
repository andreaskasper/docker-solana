#!/bin/bash

if [ -d "/wallet/" ]; then
    if [ -f "/wallet/id.json" ]
    fi
else

fi


echo "************************"
echo "please be sure to save your wallet example:"
echo "-v /safe/id.json:/root/.config/solana/id.json"
echo "************************"

export PATH="/root/.local/share/solana/install/active_release/bin:$PATH" \

if [ "$1" = 'bash' ]; then
    bash
else if [ "$1" = 'solana-keygen' ]; then
        exec "$@"
    else
        solana $@
    fi
fi
