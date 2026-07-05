#!/usr/bin/env zsh

DOTFILES=$HOME/.dotfiles

link() {
    local src=$1 dst=$2
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        read -p "Target $dst already exists. Overwrite? (y/n) " -n 1
        echo ""
        [[ $REPLY =~ ^[Yy]$ ]] || return
        rm -rf "$dst"
    fi
    echo "Linking $dst -> $src"
    ln -s "$src" "$dst"
}

echo -e "\nCreating home directory symlinks (*.symlink)"
echo "=============================="
for file in $(find -H "$DOTFILES" -maxdepth 3 -name '*.symlink'); do
    target="$HOME/.$(basename "$file" ".symlink")"
    link "$file" "$target"
done

echo -e "\n\nCreating ~/.config symlinks"
echo "=============================="
mkdir -p "$HOME/.config"
for config in "$DOTFILES/config/"*/; do
    target="$HOME/.config/$(basename "$config")"
    link "$config" "$target"
done

echo -e "\n\nCreating ~/.claude symlinks"
echo "=============================="
mkdir -p "$HOME/.claude"
link "$DOTFILES/AGENTS.md" "$HOME/.claude/AGENTS.md"
link "$DOTFILES/.claude/settings.json" "$HOME/.claude/settings.json"
