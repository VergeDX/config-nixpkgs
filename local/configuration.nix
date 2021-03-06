{ config, pkgs, lib, owner, ... }:
{
  imports =
    [
      ./boot.nix
      ./network.nix
      ./i18n.nix
      ./xserver.nix

      ./services/fstrim.nix
      ./services/xrdp.nix
      ./services/openssh.nix
      ./services/fail2ban.nix
      ./services/dnscrypt-proxy2.nix
      ./services/plymouth.nix
      ./services/TICK.nix

      ./virtualisation/binfmt.nix
      ./virtualisation/libvirt.nix
      ./virtualisation/podman.nix
      ./virtualisation/virtualbox.nix
      ./virtualisation/wine.nix

      ./programs.nix
      ./setcap.nix

      ./nix/common.nix
      ./nix/binaryCaches.nix

      ./audio.nix
      ./users.nix

      # Include the results of the hardware scan.
      ./hardware/hardware.nix
      ./hardware/disks.nix
      ./hardware/cpu.nix
      ./hardware/bluetooth.nix
      ./hardware/nvidia.nix
      ./hardware/steam.nix
      ./hardware/yubikey.nix
      ./hardware/tablet.nix
      ./hardware/openrazer.nix
    ];

  # https://github.com/ryantm/agenix#tutorial
  age.secrets = {
    "Steam/SteamLogin" = { inherit owner; file = ../secrets/Steam/SteamLogin.age; };
    "Steam/SteamPassword" = { inherit owner; file = ../secrets/Steam/SteamPassword.age; };
    "dot-wakatime-cfg" = { inherit owner; file = ../secrets/dot-wakatime-cfg.age; };
    "dot-sg_cli" = { inherit owner; file = ../secrets/dot-sg_cli.age; };
    "DRONE_TOKEN" = { inherit owner; file = ../secrets/DRONE_TOKEN.age; };
    "TICK/INFLUX_TOKEN" = { group = "telegraf"; file = ../secrets/TICK/INFLUX_TOKEN.age; };
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ home-manager git ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
