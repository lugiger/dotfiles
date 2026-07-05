# dotfiles

Personal dotfiles for macOS and Linux/WSL.

**Stack:** Nix + home-manager | Zsh + Zinit + Starship | Neovim | Tmux | WezTerm | herdr

---

## Setup

### With Nix (recommended)

Install [Determinate Nix](https://determinate.systems/posts/determinate-nix-installer):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Clone and apply:

```bash
git clone https://github.com/lugiger/dotfiles ~/.dotfiles
cd ~/.dotfiles
./rebuild.sh
```

After first run, install mise-managed tools (herdr, node, python):

```bash
mise install
```

### Without Nix (fallback)

```bash
git clone https://github.com/lugiger/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

---

## Rebuild

```bash
./rebuild.sh          # auto-detects macOS vs Linux/WSL
```

Or manually:

```bash
# macOS
darwin-rebuild switch --flake ~/.dotfiles#mac

# Linux/WSL
home-manager switch --flake ~/.dotfiles#wsl
```

---

## Structure

```
.dotfiles/
  flake.nix              # Nix entry point (macOS + WSL)
  rebuild.sh             # Convenience rebuild script
  AGENTS.md              # Global AI agent instructions (-> ~/.claude/AGENTS.md)
  home/
    default.nix          # Shared packages + config symlinks
    darwin.nix           # macOS: nix-darwin system settings + Homebrew
    linux.nix            # Linux/WSL: home-manager standalone
  config/
    nvim/                # Neovim config
    wezterm/             # WezTerm terminal config
    herdr/               # herdr multiplexer config
    mise/                # mise global tool versions
    starship.toml        # Starship prompt config
  .claude/
    settings.json        # Claude Code settings (status line, theme)
  zsh/                   # Zsh config (plugin-less, sourced by zshrc)
  git/                   # Git config
  tmux/                  # Tmux config
  install/               # Non-Nix fallback scripts
```

---

## Tools

| Tool | Purpose |
|------|---------|
| [Zinit](https://github.com/zdharma-continuum/zinit) | Fast zsh plugin manager |
| [Starship](https://starship.rs) | Cross-platform shell prompt |
| [mise](https://mise.jdx.dev) | Polyglot version manager (Node, Python, ...) |
| [herdr](https://herdr.dev) | Terminal multiplexer for WezTerm |
| [WezTerm](https://wezfurlong.org/wezterm) | GPU-accelerated terminal |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast grep |
| [bat](https://github.com/sharkdp/bat) | Better cat |
| [eza](https://eza.rocks) | Better ls |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Better cd |

---

## WezTerm on WSL

WezTerm is a native Windows app that connects into WSL. The config lives in the dotfiles repo (WSL side) and is symlinked from Windows.

### 1. Install WezTerm on Windows

```powershell
winget install wezterm
```

Or download the installer from wezfurlong.org/wezterm/installation.

### 2. Install Hack Nerd Font on Windows

WezTerm runs on Windows, so fonts must be installed there — not in WSL.

- Download `Hack.zip` from github.com/ryanoasis/nerd-fonts/releases/latest
- Unzip, select all `.ttf` files, right-click → **Install for all users**

Verify the font is available:

```powershell
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
[System.Drawing.FontFamily]::Families | Where-Object { $_.Name -like "*Hack*" }
```

### 3. Link the WezTerm config from WSL

WezTerm looks for its config at `%USERPROFILE%\.config\wezterm\`. Symlink that directory to the dotfiles repo in WSL so edits in `~/.dotfiles/config/wezterm/` take effect immediately.

Open **PowerShell as Administrator** and run:

```powershell
# Check your WSL distro name first
wsl --list

# Create the symlink (replace "Ubuntu-24.04" if your distro name differs)
New-Item -ItemType SymbolicLink `
  -Path "$env:USERPROFILE\.config\wezterm" `
  -Target "\\wsl$\Ubuntu-24.04\home\lucas\.dotfiles\config\wezterm" `
  -Force
```

### 4. Restart WezTerm

Close all WezTerm windows and reopen. It should now:
- Connect directly to WSL (no manual `wsl` command needed)
- Use the rose-pine-moon color scheme
- Render the Starship prompt with the correct font

### Troubleshooting

**Boxes or `?` instead of icons** - Font not installed on Windows or WezTerm hasn't been restarted since install. Fully close and reopen WezTerm.

**Opens CMD/PowerShell instead of WSL** - The distro name in `config/wezterm/wezterm.lua` doesn't match. Check with `wsl --list` and update `config.default_domain = "WSL:YourDistroName"`.

**Config not loading** - Open the debug overlay with `Ctrl+Shift+L` to see parse errors. Config changes in `wezterm.lua` take effect on the next new window/tab without restarting.

**Right-click menu not appearing** - Right-click in the terminal text area, not on the border or tab bar.

---

## macOS Notes

- Change `system = "aarch64-darwin"` to `"x86_64-darwin"` in `flake.nix` for Intel Mac
- Change `user = "lucas"` in `flake.nix` to match your macOS username
- Bootstrap nix-darwin on first run:
  `nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles#mac`
