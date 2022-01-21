{ ... }: {
  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
