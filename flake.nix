{
  # https://github.com/nix-community/home-manager#nix-flakes
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager.url = "github:nix-community/home-manager/release-21.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/nixos-cn/flakes#%E4%BD%BF%E7%94%A8
    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, home-manager, nixpkgs, nixos-cn, rust-overlay }:
    let system = "x86_64-linux";
    in
    {
      homeConfigurations."vanilla@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit system;

        username = "vanilla";
        homeDirectory = "/home/vanilla";

        configuration = { pkgs, ... }: {
          imports = [ ./home.nix ];

          # https://github.com/oxalica/rust-overlay#example-nixos-configuration
          nixpkgs.overlays = [ rust-overlay.overlay ];
          home.packages = with nixos-cn.legacyPackages.${system}; [
            netease-cloud-music
            (wine-wechat.override { scopedMount = false; })
            re-export.feeluown
          ] ++ [
            pkgs.rust-bin.stable.latest.default
            pkgs.rust-bin.stable.latest.rust-src
          ];
        };
      };
    };
}
