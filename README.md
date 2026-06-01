# Dotfiles

Managed with [GNU stow](https://www.gnu.org/software/stow/).

## First-time setup

```sh
git clone <repo> ~/code/dotfiles
cd ~/code/dotfiles
# If migrating from old dotbot setup, clear its symlinks first:
./teardown-dotbot          # dry-run
./teardown-dotbot --apply  # actually remove
./install
```

## Layout

Each top-level directory is a stow package. Files inside mirror their
target path relative to `$HOME`:

- `zsh/.zshrc` → `~/.zshrc`
- `nvim/.config/nvim/...` → `~/.config/nvim/...`
- `claude/.claude/...` → `~/.claude/...`

## Selective stowing

```sh
stow -t ~ -R nvim tmux        # link only these
stow -t ~ -D nvim             # unlink nvim
```

`install` calls `stow -R --no-folding` for all packages (idempotent restow).
