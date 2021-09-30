{ pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.vanilla.hashedPassword = "$6$How/Dare/You$goEDMUFMlOGkkMRjwsvW8XVv2J8Z2j.eBKvo1qXxydIPE6aPgPSKHBoWrlb.BZk9IPTs/5NmMbehK1xBzMMEv0";
  users.users.root.hashedPassword = "";

  users.users.vanilla.isNormalUser = true;
  users.users.vanilla.extraGroups = [ "wheel" "libvirtd" ];

  # https://nixos.wiki/wiki/Fish
  users.users.vanilla.shell = pkgs.fish;
  users.users.root.shell = pkgs.fish;
}
