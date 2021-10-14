{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./boot.nix
      ./network.nix
      ./i18n.nix
      ./xserver.nix

      ./services/services.nix
      ./services/xrdp.nix
      ./services/openssh.nix
      ./services/fail2ban.nix

      ./virtualisation.nix
      ./programs.nix

      ./nix/common.nix
      ./nix/flakes.nix
      ./nix/binaryCaches.nix
      ./nix/nixbuild.nix

      ./audio.nix
      ./users.nix

      # Include the results of the hardware scan.
      ./hardware/hardware.nix
    ];

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
