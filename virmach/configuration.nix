{ hostName, nixpkgs, system, nixos-unstable, ... }:
{
  imports = [
    ./disks.nix
    ./grub.nix

    ./services/openssh.nix
    ./services/v2ray.nix
    ./services/fail2ban.nix
    ./services/dnscrypt-proxy2.nix
    ./services/nginx.nix
    # ./services/trojan-go.nix
    ./services/influxdb2.nix
    ./services/telegraf.nix

    ./networking/networkmanager.nix
    ./networking/firewall.nix
    ./networking/iperf.nix

    ./users.nix
    ./boot.nix
  ];

  age.secrets."v2ray/id".file = ./secrets/v2ray/id.age;
  age.secrets."v2ray/secret".file = ./secrets/v2ray/secret.age;

  age.secrets."asf/SteamLogin".file = ./secrets/asf/SteamLogin.age;
  age.secrets."asf/SteamPassword".file = ./secrets/asf/SteamPassword.age;

  age.secrets."telegraf/INFLUX_TOKEN.env".file = ./secrets/telegraf/INFLUX_TOKEN-env.age;
  age.secrets."telegraf/config_url/system".file = ./secrets/telegraf/config_url/system.age;

  networking = { inherit hostName; };
  networking.nameservers = [ "127.0.0.1" "::1" ];

  time.timeZone = "America/Chicago";
  system.stateVersion = "21.05";

  # btrfs filesystem defragment -r -v -czstd /
  # nix.readOnlyStore = false;

  nixpkgs.overlays = [
    (self: super: {
      # https://github.com/NixOS/nixpkgs/pull/144588/files
      buildGo117Module = (import nixpkgs { inherit system; }).pkgs.callPackage
        "${nixos-unstable}/pkgs/development/go-modules/generic/default.nix"
        { go = (import nixpkgs { inherit system; }).pkgs.go_1_17; };
    })
  ];
}
