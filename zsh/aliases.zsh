# reload zsh config
alias reload!='source ~/.zshrc'

alias vim="nvim"

# AI
alias cc="claude --dangerously-skip-permissions"
alias lg="lazygit"

# Edit common configs
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.config/nvim/init.vim"

# tmux
alias tmux-dev='tmux source-file ~/.dotfiles/tmux/dev-session'

# Filesystem
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Use eza for ls if available, otherwise fall back to ls
if command -v eza &>/dev/null; then
    alias l="eza -lah --git"
    alias la="eza -a"
    alias ll="eza -lh --git"
    alias lt="eza --tree"
else
    if ls --color > /dev/null 2>&1; then
        colorflag="--color"
    else
        colorflag="-G"
    fi
    alias l="ls -lah ${colorflag}"
    alias la="ls -AF ${colorflag}"
    alias ll="ls -lFh ${colorflag}"
fi

alias lld="ls -l | grep ^d"
alias rmf="rm -rf"

# Use bat for cat if available
if command -v bat &>/dev/null; then
    alias cat="bat --pager=never"
fi

# Helpers
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h -c'

# Cross-platform clipboard copy
if command -v pbcopy &>/dev/null; then
    alias copy="pbcopy"
elif command -v xclip &>/dev/null; then
    alias copy="xclip -selection clipboard"
elif command -v xsel &>/dev/null; then
    alias copy="xsel --clipboard --input"
elif command -v clip.exe &>/dev/null; then
    alias copy="clip.exe"
fi

# IP addresses
alias localip="ip route get 1 | awk '{print \$7}' 2>/dev/null || ifconfig | grep 'inet ' | grep -v 127.0.0.1"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# File size
alias fs="stat -c '%s bytes' 2>/dev/null || stat -f '%z bytes'"

# ROT13
alias rot13='tr a-zA-Z n-za-mN-ZA-M'
