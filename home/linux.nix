{ pkgs, user, ... }:
{
  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [
    xclip  # clipboard support for tmux + neovim in WSL
  ];

  # herdr is installed via mise (see config/mise/config.toml)
  # After `home-manager switch`, run: mise install
}
