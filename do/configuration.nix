{ ... }:
{
  imports = [ ./services/cloud-init.nix ./services/openssh.nix ]
    ++ [ ./users.nix ];

  fileSystems = { "/" = { device = "/dev/vda1"; fsType = "ext4"; }; };
  boot.loader.grub.device = "/dev/vda";
}
