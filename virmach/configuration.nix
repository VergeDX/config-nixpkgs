{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./grub.nix
    ./openssh.nix
    ./networkmanager.nix
    ./users.nix
  ];

  system.stateVersion = "21.05";
}
