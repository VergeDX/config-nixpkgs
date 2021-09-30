{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./boot.nix
      ./network.nix
      ./i18n.nix
      ./xserver.nix

      ./services/services.nix
      ./services/openssh-fail2ban.nix
      ./services/influxdb2.nix
      ./services/telegraf.nix

      ./virtualisation.nix
      ./programs.nix
      ./nix.nix
      ./audio.nix
      ./users.nix

      # Include the results of the hardware scan.
      ./hardware/hardware.nix
    ];

  age.secrets = {
    "telegraf/INFLUX_TOKEN.env".file = ./secrets/telegraf/INFLUX_TOKEN-env.age;
    "telegraf/config.env".file = ./secrets/telegraf/config-env.age;

    "influxdb2/influxdb-selfsigned.crt".file =
      ./secrets/influxdb2/influxdb-selfsigned-crt.age;
    "influxdb2/influxdb-selfsigned.key".file =
      ./secrets/influxdb2/influxdb-selfsigned-key.age;
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ home-manager gjs git ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
