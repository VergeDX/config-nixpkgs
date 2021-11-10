{ hostName, ... }:
{
  imports = [
    ./disks.nix
    ./grub.nix

    ./services/openssh.nix
    ./services/v2ray.nix
    ./services/fail2ban.nix
    ./services/dnscrypt-proxy2.nix

    ./networking/networkmanager.nix
    ./networking/firewall.nix

    ./users.nix
    ./boot.nix
  ];

  networking = { inherit hostName; };
  networking.nameservers = [ "127.0.0.1" "::1" ];
  system.stateVersion = "21.05";

  # btrfs filesystem defragment -r -v -czstd /
  # nix.readOnlyStore = false;
}
