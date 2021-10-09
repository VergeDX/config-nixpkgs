{
  # https://github.com/NixOS/nixos-hardware#using-nix-flakes-support
  inputs.nixos-hardware.url = github:NixOS/nixos-hardware/master;

  # https://github.com/nix-community/home-manager#nix-flakes
  # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-935625041
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";

  # https://github.com/serokell/deploy-rs
  inputs.deploy-rs.url = "github:serokell/deploy-rs";
  # https://github.com/ryantm/agenix#flakes
  inputs.agenix.url = "github:ryantm/agenix";
  inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  # https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS
  outputs = { self, nixpkgs, nixos-hardware, home-manager, deploy-rs, agenix, nixos-unstable }:
    let rpi = {
      hostName = "NixOS-Raspi";
      arch = "aarch64-linux";
      user = "vanilla";
    }; in
    rec {
      # nix build .#nixosConfigurations.NixOS-Raspi.config.system.build.sdImage -vL
      nixosConfigurations."${rpi.hostName}" = nixpkgs.lib.nixosSystem {
        system = "${rpi.arch}";
        modules = [
          # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"

          ./configuration.nix
          nixos-hardware.nixosModules.raspberry-pi-4
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${rpi.user}" = import ./home-manager/home.nix;
          }
          agenix.nixosModules.age
          # https://nixos.org/manual/nixos/stable/#sec-replace-modules
          "${nixos-unstable}/nixos/modules/services/databases/influxdb2.nix"
        ];
      };

      deploy.nodes."${rpi.hostName}" = rec {
        # https://github.com/NickCao/flakes/blob/d874d24e5718e34141647e1048cb489afa50808b/flake.nix#L109
        hostname = "192.168.110.71";
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
