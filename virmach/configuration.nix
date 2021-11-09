{ ... }:
{
  imports = [
    ./disks.nix
    ./grub.nix
    ./openssh.nix
    ./networkmanager.nix
    ./users.nix
    ./boot.nix
  ];

  system.stateVersion = "21.05";
}
