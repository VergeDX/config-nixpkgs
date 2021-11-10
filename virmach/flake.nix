{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    deploy-rs.url = "github:serokell/deploy-rs";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-21.05";
  };

  outputs = { self, nixpkgs, deploy-rs, nixos-unstable, home-manager, ... }:
    let
      hostName = "VirMach-V2Ray";
      system = "x86_64-linux";
      pkgs-unstable = import nixos-unstable { inherit system; };
    in
    rec {
      nixosConfigurations."${hostName}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hostName pkgs-unstable; };

        modules = [
          ./configuration.nix
          { nixpkgs.overlays = [ (self: super: { v2ray = pkgs-unstable.v2ray; }) ]; }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."root" = import ./home.nix;
          }
        ];
      };

      deploy.nodes."${hostName}" = rec {
        hostname = "107.173.141.139";

        sshUser = "root";
        profiles.system = {
          user = "${sshUser}";

          path = deploy-rs.lib."${system}".activate.nixos nixosConfigurations."${hostName}";
          fastConnection = true;
        };
      };
    };
}
