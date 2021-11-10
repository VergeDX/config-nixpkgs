{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  inputs.deploy-rs.url = "github:serokell/deploy-rs";
  inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, deploy-rs, nixos-unstable, ... }:
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
