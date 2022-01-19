{
  # https://github.com/nix-community/home-manager#nix-flakes
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-21.05";

    # https://hydra.nixos.org/build/143801064#tabs-buildinputs
    nixpkgs-29f57e4.url = "github:NixOS/nixpkgs/29f57e475266edbb57d995c044aba3adf7f71298";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

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
  };

  outputs = { self, home-manager, nixpkgs, agenix, nur, ... }@inputs:
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

          nixpkgs.overlays = (with inputs; [ nur.overlay deploy-rs.overlay ])
            ++ (with inputs; [ Barbfish.overlay ]);

          home.packages = [
            pkgs.nur.repos.linyinfeng.wemeet
            pkgs.gnome.cheese
          ] ++ [ pkgs.deploy-rs.deploy-rs ]
          ++ [ agenix.defaultPackage.x86_64-linux ];
        };
      };

      kdna = let pkgs = import nixpkgs { inherit system; overlays = [ nur.overlay ]; }; in
        (pkgs.callPackage ./packages/patches/kotatogram-desktop-no-ad.nix { });
    };
}
