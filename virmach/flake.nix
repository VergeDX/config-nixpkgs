{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  inputs.deploy-rs.url = "github:serokell/deploy-rs";

  # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
  outputs = { self, nixpkgs, deploy-rs, ... }:
    let
      hostName = "VirMach-V2Ray";
      system = "x86_64-linux";
    in
    rec {
      nixosConfigurations."${hostName}" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };

      deploy.nodes."${hostName}" = rec {
        hostname = "cs.lt.nkeo.top";
        sshOpts = [ "-p" "55169" ];

        sshUser = "root";
        profiles.system = {
          user = "${sshUser}";

          path = deploy-rs.lib."${system}".activate.nixos nixosConfigurations."${hostName}";
          fastConnection = true;
        };
      };
    };
}
