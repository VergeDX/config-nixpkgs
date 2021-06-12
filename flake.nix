{
  # https://github.com/nix-community/home-manager#nix-flakes
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    home-manager.url = "github:nix-community/home-manager";

    # https://github.com/nixos-cn/flakes#%E4%BD%BF%E7%94%A8
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs, nixos-cn }:
    let system = "x86_64-linux";
    in
    {
      homeConfigurations."vanilla@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit system;
        username = "vanilla";
        homeDirectory = "/home/vanilla";
        configuration = { ... }: {
          imports = [ ./home.nix ];
          home.packages = with nixos-cn.legacyPackages.${system}; [
            netease-cloud-music
            (wine-wechat.override { scopedMount = false; })
          ];
        };
      };
    };
}
