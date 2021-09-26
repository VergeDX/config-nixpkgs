{
  # https://github.com/NixOS/nixos-hardware#using-nix-flakes-support
  inputs.nixos-hardware.url = github:NixOS/nixos-hardware/master;
  # https://github.com/nix-community/home-manager#nix-flakes
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";

  # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
  outputs = { self, nixpkgs, nixos-hardware, home-manager }: {
    nixosConfigurations."NixOS-Raspi" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.raspberry-pi-4
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."vanilla" = import ./home-manager/home.nix;
        }
      ];
    };
  };
}
