{ hostName, ... }:
{
  imports = [
    ./disks.nix
    ./grub.nix

    ./services/openssh.nix
    ./services/v2ray.nix
    ./services/fail2ban.nix

    ./networking/networkmanager.nix

    ./users.nix
    ./boot.nix
  ];

  networking = { inherit hostName; };
  system.stateVersion = "21.05";

  # btrfs filesystem defragment -r -v -czstd /
  # nix.readOnlyStore = false;
}
