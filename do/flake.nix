{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    deploy-rs.url = "github:serokell/deploy-rs";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix/0.10.1";
  };

  outputs = { self, nixpkgs, deploy-rs, flake-utils, ... }@inputs:
    let system = "x86_64-linux"; in
    # https://github.com/numtide/flake-utils#example
    (flake-utils.lib.eachSystem [ "${system}" ] (system:
      rec {
        # https://justinas.org/nixos-in-the-cloud-step-by-step-part-1
        packages."digitalOceanImage" = ((nixpkgs.legacyPackages."${system}").nixos {
          imports = [ "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix" ];
        }).digitalOceanImage;
      }
    )) // {
      deploy.nodes."nixos" = rec {
        hostname = "159.65.135.68";
        sshUser = "root";

        profiles.system = {
          user = "${sshUser}";
          path = deploy-rs.lib."${system}".activate.nixos (nixpkgs.lib.nixosSystem
            { inherit system; modules = [ ./configuration.nix ]; specialArgs = { inherit inputs; }; });
          fastConnection = true;
        };
      };
    };
}
