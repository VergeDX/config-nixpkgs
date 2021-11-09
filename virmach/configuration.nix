{ hostName, ... }:
{
  imports = [
    ./disks.nix
    ./grub.nix
    ./openssh.nix
    ./networkmanager.nix
    ./users.nix
    ./boot.nix
    ./v2ray.nix
  ];

  networking = { inherit hostName; };
  system.stateVersion = "21.05";
}
