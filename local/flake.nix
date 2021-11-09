{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  # https://github.com/ryantm/agenix#flakes
  inputs.agenix.url = "github:ryantm/agenix";

  inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs, agenix, nixos-unstable, ... }@inputs: {
    # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
    nixosConfigurations."NixOS-Laptop" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };

      modules = [
        ./configuration.nix
        agenix.nixosModules.age

        {
          # https://nixos.wiki/wiki/Overlays#In_NixOS
          nixpkgs.overlays = [
            (self: super: {
              fish = (import nixos-unstable { inherit system; }).pkgs.fish;
              nixFlakes = (import nixos-unstable { inherit system; }).pkgs.nixFlakes;
              linuxPackages_xanmod = (import nixos-unstable {
                inherit system;
                config.allowUnfree = true;
              }).pkgs.linuxPackages_xanmod;
            })
          ];
        }
      ];
    };
  };
}
