{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  inputs.agenix.url = "github:ryantm/agenix";
  inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, agenix, nixos-unstable, ... }: {
    # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
    nixosConfigurations."NixOS-Laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        # https://github.com/ryantm/agenix#flakes
        agenix.nixosModules.age
        # https://nixos.org/manual/nixos/stable/#sec-replace-modules
        "${nixos-unstable}/nixos/modules/services/databases/influxdb2.nix"
      ];
    };
  };
}
