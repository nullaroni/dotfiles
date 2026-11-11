# dotfiles

My personal macOS dotfiles. Managed as a bare Git repo and symlinked by [macbook-setup](https://github.com/peytonmscott/macbook-setup).

## What's Inside

| Path | Symlinks To | Tool |
|------|------------|------|
| `zsh/zshrc` | `~/.zshrc` | Zsh shell config |
| `git/gitignore_global` | `~/.gitignore_global` | Global Git ignore patterns |
| `ghostty/config` | `~/.config/ghostty` | Ghostty terminal |
| `aerospace/aerospace.toml` | `~/.config/aerospace/aerospace.toml` | AeroSpace tiling WM |
| `omniwm/settings.toml` | `~/.config/omniwm` | OmniWM tiling WM |
| `nvim/init.lua` | `~/.config/nvim` | Neovim config |
| `starship/starship.toml` | `~/.config/starship.toml` | Starship prompt |
| `yazi/yazi.toml` | `~/.config/yazi` | Yazi file manager |

## Install

### Via macbook-setup (recommended)

```bash
git clone https://github.com/peytonmscott/macbook-setup.git ~/Developer/macbook-setup
cd ~/Developer/macbook-setup
./bootstrap.sh --role personal \
  --git-name "Your Name" \
  --git-email "your.email@example.com" \
  --dotfiles-repo "https://github.com/yourusername/dotfiles.git"
```

### Manual

```bash
git clone https://github.com/peytonmscott/dotfiles.git ~/Developer/dotfiles
ln -sf ~/Developer/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/Developer/dotfiles/git/gitignore_global ~/.gitignore_global
ln -sf ~/Developer/dotfiles/ghostty ~/.config/ghostty
ln -sf ~/Developer/dotfiles/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/Developer/dotfiles/omniwm ~/.config/omniwm
ln -sf ~/Developer/dotfiles/nvim ~/.config/nvim
ln -sf ~/Developer/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sf ~/Developer/dotfiles/yazi ~/.config/yazi
```

## Tool Notes

### Neovim

- Uses `vim.pack.add()` (Neovim 0.12+) — no plugin manager needed
- Plugins: Telescope, Treesitter, LSP, Sidekick, Copilot, Which-key, Catppuccin, and more
- Kotlin LSP support via [kotlin.nvim](https://github.com/AlexandrosAlexiou/kotlin.nvim)

### AeroSpace

Tiling window manager config with:
- Alt-based navigation (vim keys)
- 10 workspaces
- Auto-layout rules for apps like Teams, Outlook, Finder
- Service mode for reload/flatten/close-all

### OmniWM

Alternative tiling window manager (Niri/Hyprland-inspired) with:
- Two layout modes: Niri (scrolling columns) and Dwindle (BSP)
- Vim key navigation (Option + h/j/k/l)
- 10 workspaces with app auto-assignment
- Quake terminal, command palette, overview mode
- App rules for floating (Finder, Calculator, etc.)
- Workspace bar and hidden status bar icons

### Omarchy (Linux)

[Omarchy](https://omarchy.org/) / Hyprland setup that mirrors the AeroSpace keys. Set up a fresh install with:

```bash
git clone https://github.com/nullaroni/dotfiles.git ~/Developer/dotfiles
~/Developer/dotfiles/omarchy/install.sh
```

| Path | Symlinks To |
|------|------------|
| `omarchy/hypr/bindings.lua` | `~/.config/hypr/bindings.lua` |
| `omarchy/hypr/looknfeel.lua` | `~/.config/hypr/looknfeel.lua` |
| `omarchy/hypr/monitors.lua` | `~/.config/hypr/monitors.lua` |
| `omarchy/omarchy/shell.json` | `~/.config/omarchy/shell.json` |

The installer backs up any existing files, links these in, sets the Gruvbox theme, reloads Hyprland, and runs `limine.sh` with sudo (skip it with `SKIP_LIMINE=1`).

- AeroSpace-style keys: `Alt+h/j/k/l` focus, `Alt+Shift+h/j/k/l` move, `Alt+1..0` workspaces, `Alt+Shift+1..0` send window, `Alt+Tab` previous workspace, `Alt+Shift+R` resize mode, `Alt+Shift+;` service mode
- Rounded window corners, 1.5x monitor scale
- 12-hour bar clock and world clock cities
- `limine.sh`: boot menu always shown, 15 second timeout, Windows Boot Manager detected

### Zsh

- Starship prompt
- Zoxide (`cd` hooked for fuzzy jumping)
- FZF key bindings
- Homebrew shellenv
- Conditional paths for Kotlin and Android SDK

## License

MIT
