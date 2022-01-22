{ config, pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "";
    shell = pkgs.fish;
  };

  # Never forget: `smbpasswd -a vanilla`.
  users.users."vanilla".isNormalUser = true;
}
