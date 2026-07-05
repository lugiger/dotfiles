{
  description = "Lucas Bernoulli's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager, ... }:
  let
    user = "lucas";
  in {
    # macOS: darwin-rebuild switch --flake ~/.dotfiles#mac
    # Change system to "x86_64-darwin" for Intel Mac
    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./home/darwin.nix
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit user; };
          home-manager.users.${user} = {
            imports = [ ./home/default.nix ];
            home.username = user;
            home.homeDirectory = "/Users/${user}";
          };
        }
      ];
    };

    # Linux/WSL: home-manager switch --flake ~/.dotfiles#wsl
    homeConfigurations."wsl" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit user; };
      modules = [
        ./home/default.nix
        ./home/linux.nix
      ];
    };
  };
}
