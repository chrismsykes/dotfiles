# dotfiles

My dotfiles, managed with [chezmoi](https://github.com/twpayne/chezmoi).

## Install

Fresh machine (Ubuntu ships `wget` but not `curl`; macOS has `curl`):

```sh
bash -c "$(wget -qO- https://raw.githubusercontent.com/chrismsykes/dotfiles/main/install.sh)"
# or
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chrismsykes/dotfiles/main/install.sh)"
```

Use `bash -c "$(...)"` rather than piping into bash so chezmoi can prompt
for `headless`/`personal`. Existing chezmoi install: `chezmoi init --apply chrismsykes`.

## Dependencies

- [1Password CLI](https://developer.1password.com/docs/cli/) for secrets
- [mise](https://mise.jdx.dev/) for runtime/tool management
