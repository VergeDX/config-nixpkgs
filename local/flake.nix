{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  # https://github.com/ryantm/agenix#flakes
  inputs.agenix.url = "github:ryantm/agenix";

  outputs = { self, nixpkgs, agenix, ... }@inputs: {
    # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
    nixosConfigurations."NixOS-Laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };

      modules = [
        ./configuration.nix
        agenix.nixosModules.age
      ];
    };
  };
}
