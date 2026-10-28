#!/bin/sh
set -eu

PROJECT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BREW=""

if command -v brew >/dev/null 2>&1; then
    BREW="$(command -v brew)"
else
    for candidate in /usr/local/Homebrew/bin/brew /opt/homebrew/bin/brew; do
        if [ -x "$candidate" ]; then
            BREW="$candidate"
            break
        fi
    done
fi

if [ -n "$BREW" ]; then
    BREW_PREFIX="$("$BREW" --prefix)"
    if ! command -v az >/dev/null 2>&1; then
        for candidate in "$BREW_PREFIX"/Caskroom/azure-cli/*/bin; do
            if [ -x "$candidate/az" ]; then
                PATH="$candidate:$PATH"
                export PATH
                break
            fi
        done
    fi

    AZURE_PYTHON="$BREW_PREFIX/opt/python@3.14/bin/python3.14"
    if [ -x "$AZURE_PYTHON" ]; then
        AZ_PYTHON="$AZURE_PYTHON"
        export AZ_PYTHON
    fi
fi

if ! command -v az >/dev/null 2>&1; then
    echo "Azure CLI no está disponible. Ejecuta ./install-macos.sh y vuelve a iniciar sesión con az login." >&2
    exit 1
fi

if [ ! -x "$PROJECT_DIR/.venv/bin/python" ]; then
    echo "No se encontró el entorno Python. Ejecuta ./install-macos.sh primero." >&2
    exit 1
fi

cd "$PROJECT_DIR"
exec .venv/bin/python run_agent.py
