{
  # https://github.com/nix-community/home-manager#nix-flakes
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    # https://hydra.nixos.org/build/143801064#tabs-buildinputs
    nixpkgs-29f57e4.url = "github:NixOS/nixpkgs/29f57e475266edbb57d995c044aba3adf7f71298";

    # https://github.com/nix-community/fenix#usage
    fenix.url = "github:nix-community/fenix";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
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

    # https://github.com/MidAutumnMoon/Barbfish#nix-use-flake
    Barbfish.url = "github:MidAutumnMoon/Barbfish";

    # https://gitlab.com/zanc/overlays
    zanc-overlays.url = "gitlab:zanc/overlays";
  };

  outputs = { self, home-manager, nixpkgs, nixos-cn, agenix, ... }@inputs:
    let system = "x86_64-linux";
    in
    {
      homeConfigurations."vanilla@NixOS-Laptop" = home-manager.lib.homeManagerConfiguration {
        inherit system;

        # https://nix-community.github.io/home-manager/nixos-options.html
        extraSpecialArgs = { inherit inputs system; };

        username = "vanilla";
        homeDirectory = "/home/vanilla";

        configuration = { pkgs, ... }: {
          imports = [ ./home.nix ];

          nixpkgs.overlays = (with inputs; [ fenix.overlay nur.overlay deploy-rs.overlay ])
            ++ (with inputs; [ Barbfish.overlay ]);

          home.packages = with nixos-cn.legacyPackages.${system}; [ ] ++ [
            pkgs.nur.repos.linyinfeng.wemeet
            pkgs.gnome.cheese
          ] ++ [ pkgs.deploy-rs.deploy-rs ]
            ++ [ agenix.defaultPackage.x86_64-linux ];
        };
      };
    };
}
