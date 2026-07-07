{ config, pkgs, lib, user, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  # Creates a direct symlink to the dotfiles path (editable without rebuild)
  ln = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in {
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    bat           # better cat
    eza           # better ls
    fd            # better find
    fzf           # fuzzy finder
    gh            # github cli
    git-standup   # what did I do yesterday?
    jq            # json processor
    lazygit       # git tui
    mise          # polyglot version manager (node, python, ruby, go, ...)
    neovim
    nerd-fonts.hack
    ripgrep       # better grep
    starship      # shell prompt
    tmux
    tree
    wget
    zoxide        # better cd
    zsh
  ];

  # Symlink all config files directly to dotfiles (stay editable in-place)
  home.file = {
    ".config/nvim".source           = ln "config/nvim";
    ".config/wezterm".source        = ln "config/wezterm";
    ".config/herdr".source          = ln "config/herdr";
    ".config/mise".source           = ln "config/mise";
    ".config/starship.toml".source  = ln "config/starship.toml";
    ".claude/CLAUDE.md".source       = ln "AGENTS.md";
    "AGENTS.md".source               = ln "AGENTS.md";
    ".claude/settings.json".source  = ln ".claude/settings.json";
    ".claude/skills".source         = ln ".claude/skills";
    ".claude/commands".source       = ln ".claude/commands";
    ".zshrc".source                 = ln "zsh/zshrc.symlink";
    ".gitconfig".source             = ln "git/gitconfig.symlink";
    ".gitignore_global".source      = ln "git/gitignore_global.symlink";
    ".tmux.conf".source             = ln "tmux/tmux.conf.symlink";
    ".ideavimrc".source             = ln "ideavim/ideavimrc.symlink";
  };

  programs.home-manager.enable = true;
}
