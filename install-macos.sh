#!/bin/sh
set -eu

BREW="$(command -v brew 2>/dev/null || true)"
if [ -z "$BREW" ]; then
    for candidate in /usr/local/Homebrew/bin/brew /opt/homebrew/bin/brew; do
        if [ -x "$candidate" ]; then
            BREW="$candidate"
            break
        fi
    done
fi

if ! command -v az >/dev/null 2>&1; then
    for candidate in /usr/local/Homebrew/Caskroom/azure-cli/*/bin /opt/homebrew/Caskroom/azure-cli/*/bin; do
        if [ -x "$candidate/az" ]; then
            PATH="$candidate:$PATH"
            export PATH
            break
        fi
    done
fi

if ! command -v az >/dev/null 2>&1; then
    if [ -z "$BREW" ]; then
        echo "Instala Azure CLI desde https://learn.microsoft.com/cli/azure/install-azure-cli-macos" >&2
        exit 1
    fi
    "$BREW" install azure-cli
fi

python3 -m venv .venv
. ./.venv/bin/activate
python -m pip install -r requirements.txt