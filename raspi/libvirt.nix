{ ... }:
{
  # https://nixos.wiki/wiki/Libvirt
  virtualisation.libvirtd.enable = true;
  users.users."vanilla".extraGroups = [ "libvirtd" ];

  # https://nixos.wiki/wiki/Virt-manager
  programs.dconf.enable = true;
}
