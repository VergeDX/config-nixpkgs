{
  # https://github.com/nix-community/home-manager#nix-flakes
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    # https://github.com/nixos-cn/flakes#%E4%BD%BF%E7%94%A8
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs, nixos-cn }: {
    homeConfigurations."vanilla@nixos" = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      username = "vanilla";
      homeDirectory = "/home/vanilla";
      configuration = { ... }: { imports = [ ./home.nix ]; };
    };
  };
}
