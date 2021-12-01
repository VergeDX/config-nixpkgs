{ ... }:
{
  # https://nixos.wiki/wiki/VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "vanilla" ];

  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
