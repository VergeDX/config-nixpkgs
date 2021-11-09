{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  inputs.deploy-rs.url = "github:serokell/deploy-rs";

  outputs = { self, nixpkgs, deploy-rs, ... }:
    let
      hostName = "VirMach-V2Ray";
      system = "x86_64-linux";
    in
    rec {
      nixosConfigurations."${hostName}" = nixpkgs.lib.nixosSystem {
        inherit system; specialArgs = { inherit hostName; };
        modules = [ ./configuration.nix ];
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
