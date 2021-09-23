{ ... }:
{
  imports = [
    ./installer/issuecomment-918359063.nix
    ./installer/networking-wireless.nix

    ./nix.nix
    ./users.nix
  ];

  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  boot.loader.systemd-boot.enable = true;
}
