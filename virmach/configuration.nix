{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./grub.nix
    ./openssh.nix
  ];

  networking.networkmanager.enable = true;

  system.stateVersion = "21.05";
}
