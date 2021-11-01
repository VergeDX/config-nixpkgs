{
  # https://github.com/nix-community/home-manager#nix-flakes
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/nixos-cn/flakes#%E4%BD%BF%E7%94%A8
    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/nix-community/NUR#flake-support
    nur.url = github:nix-community/NUR;
    # https://github.com/ryantm/agenix#flakes
    agenix.url = "github:ryantm/agenix";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/neovim-nightly-overlay#to-use-the-overlay
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # https://github.com/MidAutumnMoon/Barbfish#nix-use-flake
    Barbfish.url = "github:MidAutumnMoon/Barbfish";
  };

  outputs = { self, home-manager, nixpkgs, nixos-cn, rust-overlay, nur, deploy-rs, agenix, ... }@inputs:
    let system = "x86_64-linux";
    in
    {
      homeConfigurations."vanilla@NixOS-Laptop" = home-manager.lib.homeManagerConfiguration {
        inherit system;

        username = "vanilla";
        homeDirectory = "/home/vanilla";

        configuration = { pkgs, ... }: {
          imports = [ ./home.nix ];

          # https://github.com/oxalica/rust-overlay#example-nixos-configuration
          nixpkgs.overlays = [ rust-overlay.overlay nur.overlay deploy-rs.overlay ]
            ++ (with inputs; [ neovim-nightly-overlay.overlay Barbfish.overlay ]);

          home.packages = with nixos-cn.legacyPackages.${system}; [ ] ++ [
            pkgs.nur.repos.linyinfeng.wemeet
            pkgs.gnome.cheese
          ] ++ [ pkgs.deploy-rs.deploy-rs ]
            ++ [ agenix.defaultPackage.x86_64-linux ];
        };
      };
    };
}
