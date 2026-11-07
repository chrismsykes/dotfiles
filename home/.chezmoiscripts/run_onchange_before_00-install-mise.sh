#!/bin/bash

set -eufo pipefail

# Install mise if not present
if ! command -v mise &> /dev/null; then
    echo "Installing mise..."
    curl https://mise.run | sh
fi

# Ensure mise is in PATH for this script
export PATH="$HOME/.local/bin:$PATH"

# Install tools defined in mise config
echo "Installing mise tools..."
mise install --yes
