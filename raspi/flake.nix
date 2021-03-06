{
  # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-935625041
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";

  # https://github.com/serokell/deploy-rs
  inputs.deploy-rs.url = "github:serokell/deploy-rs";

  # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
  outputs = { self, nixpkgs, deploy-rs, ... }:
    let rpi = { hostName = "NixOS-Raspi"; arch = "aarch64-linux"; }; in
    rec {
      # nix build .#nixosConfigurations.NixOS-Raspi.config.system.build.sdImage -vL
      nixosConfigurations."${rpi.hostName}" = nixpkgs.lib.nixosSystem {
        system = "${rpi.arch}";
        modules = [
          # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          { sdImage.compressImage = false; }

          ./configuration.nix
        ];

        specialArgs = {
          inherit self;
        };
      };

      deploy.nodes."${rpi.hostName}" = rec {
        # https://github.com/NickCao/flakes/blob/d874d24e5718e34141647e1048cb489afa50808b/flake.nix#L109
        hostname = "192.168.0.102";
        # https://github.com/serokell/deploy-rs/issues/25#issuecomment-740067529
        sshUser = "root";

        profiles.system = {
          user = "${sshUser}";
          path = deploy-rs.lib."${rpi.arch}".activate.nixos nixosConfigurations."${rpi.hostName}";

          # Copy the whole closure instead of letting the node substitute.
          fastConnection = true;
        };
      };
    };
}
