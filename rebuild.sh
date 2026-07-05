#!/usr/bin/env bash
set -e

if ! command -v nix &>/dev/null; then
    echo "Nix not installed. Install via: https://determinate.systems/posts/determinate-nix-installer"
    echo "Then re-run this script."
    exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v darwin-rebuild &>/dev/null; then
        echo "nix-darwin not bootstrapped yet. Run:"
        echo "  nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles#mac"
        exit 1
    fi
    echo "Rebuilding macOS (nix-darwin)..."
    darwin-rebuild switch --flake ~/.dotfiles#mac
else
    if ! command -v home-manager &>/dev/null; then
        echo "Bootstrapping home-manager..."
        nix run home-manager/master -- switch --flake ~/.dotfiles#wsl
    else
        echo "Rebuilding Linux/WSL (home-manager)..."
        home-manager switch --flake ~/.dotfiles#wsl
    fi
fi
