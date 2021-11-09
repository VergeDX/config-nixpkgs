{ hostName, ... }:
{
  imports = [
    ./disks.nix
    ./grub.nix
    ./openssh.nix
    ./networkmanager.nix
    ./users.nix
    ./boot.nix
  ];

  networking = { inherit hostName; };
  system.stateVersion = "21.05";
}
