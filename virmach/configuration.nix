{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./grub.nix
    ./openssh.nix
    ./networkmanager.nix
  ];

  system.stateVersion = "21.05";
}
