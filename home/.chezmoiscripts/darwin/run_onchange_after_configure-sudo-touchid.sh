#!/bin/bash

set -eufo pipefail

# Touch ID for sudo, including inside tmux (via pam-reattach).
# /etc/pam.d/sudo_local survives macOS updates, unlike /etc/pam.d/sudo.

reattach=""
for prefix in /opt/homebrew /usr/local; do
	if [[ -f "$prefix/lib/pam/pam_reattach.so" ]]; then
		reattach="auth       optional       $prefix/lib/pam/pam_reattach.so ignore_ssh"
		break
	fi
done

desired="# sudo_local: managed by chezmoi
${reattach:+$reattach
}auth       sufficient     pam_tid.so"

if [[ "$(cat /etc/pam.d/sudo_local 2>/dev/null || true)" != "$desired" ]]; then
	echo "Configuring Touch ID for sudo..."
	printf '%s\n' "$desired" | sudo tee /etc/pam.d/sudo_local >/dev/null
fi
