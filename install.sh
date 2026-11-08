#!/bin/bash

set -e

echo "==> Installing dotfiles..."

# Install basic dependencies on Linux
if [ "$(uname)" = "Linux" ]; then
    if command -v apt-get &> /dev/null; then
        echo "==> Installing prerequisites..."
        sudo apt-get update -qq
        sudo apt-get install -y -qq curl git zsh
    fi
fi

# Check if this is a personal machine
is_personal() {
    case "$(hostname)" in
        bench) return 0 ;;  # Add other personal hostnames here
        *) return 1 ;;
    esac
}

# Install 1Password CLI on personal Linux machines
if [ "$(uname)" = "Linux" ] && is_personal && ! command -v op &> /dev/null; then
    echo "==> Installing 1Password CLI..."
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
        sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
        sudo tee /etc/apt/sources.list.d/1password.list > /dev/null
    sudo apt-get update -qq
    sudo apt-get install -y -qq 1password-cli
fi

# Sign in to 1Password if installed but not signed in
if command -v op &> /dev/null; then
    if ! op whoami &> /dev/null 2>&1; then
        echo "==> Setting up 1Password CLI..."
        # Use /dev/tty for full terminal access when script is piped
        if ! op account list &> /dev/null; then
            op account add </dev/tty >/dev/tty 2>&1
        fi
        eval $(op signin </dev/tty 2>/dev/tty)
    fi
fi

# Install chezmoi if not present
if ! command -v chezmoi &> /dev/null; then
    echo "==> Installing chezmoi..."
    bin_dir="$HOME/.local/bin"
    mkdir -p "$bin_dir"
    if command -v curl &> /dev/null; then
        sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$bin_dir"
    elif command -v wget &> /dev/null; then
        sh -c "$(wget -qO- https://get.chezmoi.io)" -- -b "$bin_dir"
    else
        echo "Error: curl or wget required" >&2
        exit 1
    fi
    export PATH="$bin_dir:$PATH"
fi

# Run chezmoi init --apply
echo "==> Applying dotfiles..."
if [ -t 0 ] && [ -f "$0" ]; then
    # Running from a file (./install.sh), use local source
    script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
    chezmoi init --apply "--source=$script_dir"
else
    # Piped from curl, fetch from GitHub
    chezmoi init --apply chrismsykes
fi

echo "==> Done! Start a new shell or run: exec zsh"
