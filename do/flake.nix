{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    deploy-rs.url = "github:serokell/deploy-rs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, deploy-rs, flake-utils, ... }:
    # https://github.com/numtide/flake-utils#example
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      rec {
        # https://justinas.org/nixos-in-the-cloud-step-by-step-part-1
        packages."digitalOceanImage" = ((nixpkgs.legacyPackages."${system}").nixos {
          imports = [ "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix" ];
        }).digitalOceanImage;

        deploy.nodes."nixos" = rec {
          hostname = "134.209.111.162";
          sshUser = "root";

          profiles.system = {
            user = "${sshUser}";
            path = deploy-rs.lib."x86_64-linux".activate.nixos (nixpkgs.lib.nixosSystem
              { system = "x86_64-linux"; modules = [ ./configuration.nix ]; });

            fastConnection = true;
            autoRollback = false;
          };
        };
      }
    );
}
