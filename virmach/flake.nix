{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    deploy-rs.url = "github:serokell/deploy-rs";
    home-manager.url = "github:nix-community/home-manager/release-21.11";

    agenix.url = "github:ryantm/agenix/0.10.1";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, deploy-rs, home-manager, agenix, nixos-unstable, ... }:
    let
      hostName = "VirMach-V2Ray";
      system = "x86_64-linux";
    in
    rec {
      nixosConfigurations."${hostName}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hostName nixpkgs system nixos-unstable; };

        modules = [ ./configuration.nix ]
          ++ [ home-manager.nixosModules.home-manager ]
          ++ [{ home-manager.useGlobalPkgs = true; }]
          ++ [{ home-manager.useUserPackages = true; }]
          ++ [{ home-manager.users."root" = import ./home.nix; }]
          ++ [ agenix.nixosModules.age ];
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
