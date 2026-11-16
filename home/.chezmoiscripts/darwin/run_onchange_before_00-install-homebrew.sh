#!/bin/bash

set -eufo pipefail

# Homebrew lives in /opt/homebrew on Apple Silicon and /usr/local on Intel.
if [[ -x /opt/homebrew/bin/brew || -x /usr/local/bin/brew ]]; then
	exit 0
fi

echo "Installing Homebrew (and Xcode Command Line Tools if needed)..."
# The installer needs sudo; cache credentials up front so it can run non-interactively.
sudo -v
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
