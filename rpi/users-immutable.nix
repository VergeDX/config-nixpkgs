{ config, pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.vanilla.hashedPassword = "$6$Im/A/Teapot$mQgTITBs3PAyPJy7lQGYNG.DoVYuA9nxdUKVb6/B1VxfvtP0Lj9k7N5JD4ANYADV8ljeIRGNhVfXZPSNzYMq/.";

  users.users.vanilla = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  users.users.root = {
    hashedPassword = "";
    shell = pkgs.fish;
  };
}
