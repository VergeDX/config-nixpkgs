{ hostName, ... }:
{
  imports = [
    ./disks.nix
    ./grub.nix

    ./services/openssh.nix
    ./services/v2ray.nix
    ./services/fail2ban.nix
    ./services/dnscrypt-proxy2.nix
    ./services/nginx.nix

    ./networking/networkmanager.nix
    ./networking/firewall.nix
    ./networking/iperf.nix

    ./users.nix
    ./boot.nix
  ];

  age.secrets."v2ray/id".file = ./secrets/v2ray/id.age;
  age.secrets."v2ray/secret".file = ./secrets/v2ray/secret.age;

  networking = { inherit hostName; };
  networking.nameservers = [ "127.0.0.1" "::1" ];

  time.timeZone = "America/Chicago";
  system.stateVersion = "21.05";

  # btrfs filesystem defragment -r -v -czstd /
  # nix.readOnlyStore = false;
}
