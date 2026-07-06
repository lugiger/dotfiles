# Aliases not covered by OMZ git plugin (loaded via zinit in zshrc)

# stage all deleted files
alias garm='git ls-files --deleted -z | xargs -0 git rm'

# copy current branch name to clipboard
alias cpbr='git rev-parse --abbrev-ref HEAD | copy'

# pull all submodules
alias sub-pull='git submodule foreach git pull origin main'

# rename a file in a case-sensitive way (git doesn't track case changes)
alias grn='git-rename'
function git-rename() {
    git mv $1 "${2}-"
    git mv "${2}-" $2
}

# amend last commit's author
function give-credit() {
    git commit --amend --author "$1 <$2>" -C HEAD
}
