{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
  # https://github.com/ryantm/agenix/releases/tag/0.10.0
  inputs.agenix.url = "github:ryantm/agenix/0.10.1";

  outputs = { self, nixpkgs, agenix, ... }@inputs: {
    # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
    nixosConfigurations."NixOS-Laptop" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs self;
        owner = "vanilla";
      };

      modules = [
        ./configuration.nix
        agenix.nixosModules.age
      ];
    };
  };
}
