#!/bin/bash
# =============================================================================
# docker-solana — entrypoint.sh
#
# Wraps the Solana CLI tools for easy use inside the container.
#
# Usage examples:
#   docker run -it --rm andreaskasper/solana:cli solana-keygen new
#   docker run -it --rm -v ${PWD}/id.json:/root/.config/solana/id.json:ro \
#     andreaskasper/solana:cli solana balance
#   docker run -it --rm -v ${PWD}/id.json:/root/.config/solana/id.json:ro \
#     andreaskasper/solana:cli spl-token accounts
#   docker run -it --rm andreaskasper/solana:cli bash
#
# Wallet path inside the container: /root/.config/solana/id.json
# =============================================================================

set -e

# ─── PATH SETUP ──────────────────────────────────────────────────────────────
# Add Solana/Agave CLI binaries to PATH.
# Installed by the Agave installer to the following location.
export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"

# ─── WALLET CHECK ────────────────────────────────────────────────────────────
# Warn the user if no wallet file is present. This is non-fatal — some commands
# (e.g. solana-keygen new, solana config) do not require a wallet.
WALLET_PATH="/root/.config/solana/id.json"
if [ ! -f "${WALLET_PATH}" ]; then
    echo ""
    echo "┌─────────────────────────────────────────────────────────┐"
    echo "│  ⚠  No wallet file found at ${WALLET_PATH}  │"
    echo "├─────────────────────────────────────────────────────────┤"
    echo "│  To use an existing wallet, mount it at runtime:        │"
    echo "│    -v /path/to/id.json:${WALLET_PATH}:ro  │"
    echo "│                                                         │"
    echo "│  To generate a new wallet:                              │"
    echo "│    docker run -it andreaskasper/solana:cli \\            │"
    echo "│      solana-keygen new                                  │"
    echo "│  ⚠  Save your seed phrase and keep it safe!             │"
    echo "└─────────────────────────────────────────────────────────┘"
    echo ""
fi

# ─── COMMAND DISPATCH ────────────────────────────────────────────────────────
# Route to the correct CLI tool based on the first argument.
# Falls back to the `solana` command for any unknown argument (e.g. `balance`,
# `transfer`, `airdrop`, etc.) so the container behaves like a direct alias.
case "$1" in

    # Drop into an interactive bash shell — useful for debugging
    bash | sh)
        exec bash
        ;;

    # Pass through the Solana CLI tools directly, preserving all arguments
    solana | solana-keygen | spl-token)
        exec "$@"
        ;;

    # Default: forward all arguments to the solana binary
    # Allows: docker run ... andreaskasper/solana:cli balance
    #     →   solana balance
    *)
        exec solana "$@"
        ;;
esac
