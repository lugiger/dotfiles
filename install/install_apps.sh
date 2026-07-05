#!/usr/bin/env bash

# Install tools via Homebrew (macOS) or system package manager (Linux/WSL)
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo -e "\n\nInstalling Homebrew packages..."
    echo "=============================="

    formulas=(
        bat
        diff-so-fancy
        eza
        fzf
        gh
        git
        git-standup
        grep
        mise
        neovim
        ripgrep
        starship
        tmux
        tree
        wget
        zoxide
        zsh
    )

    for formula in "${formulas[@]}"; do
        if brew list "$formula" &>/dev/null; then
            echo "$formula already installed... skipping."
        else
            brew install "$formula"
        fi
    done

    cask_formulas=(
        rectangle
    )

    for formula in "${cask_formulas[@]}"; do
        if brew list --cask "$formula" &>/dev/null; then
            echo "$formula already installed... skipping."
        else
            brew install --cask "$formula"
        fi
    done

    echo "Installing fzf key bindings..."
    "$(brew --prefix fzf)/install" --all --no-update-rc

elif command -v apt-get &>/dev/null; then
    echo -e "\n\nInstalling packages via apt..."
    echo "=============================="
    sudo apt-get update
    sudo apt-get install -y \
        bat \
        curl \
        fzf \
        git \
        neovim \
        ripgrep \
        tmux \
        tree \
        wget \
        zsh \
        zoxide

    echo "Installing mise..."
    curl https://mise.run | sh

    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh

    echo "Installing eza..."
    sudo apt-get install -y gpg
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt-get update && sudo apt-get install -y eza

    echo "Installing gh (GitHub CLI)..."
    type -p curl >/dev/null || sudo apt-get install -y curl
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
    sudo apt-get update && sudo apt-get install -y gh
fi

echo "Installing Zinit plugin manager..."
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
else
    echo "Zinit already installed... skipping."
fi

echo "Done."
