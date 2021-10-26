{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";

  outputs = { self, nixpkgs, ... }@inputs: {
    # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
    nixosConfigurations."NixOS-Laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };
      modules = [ ./configuration.nix ];
    };
  };
}
