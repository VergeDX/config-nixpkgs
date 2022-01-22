{ config, pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "";
    shell = pkgs.fish;
  };

  # Never forget: `smbpasswd -a vanilla`.
  users.users."vanilla".isNormalUser = true;
  users.users."vanilla".hashedPassword = "$6$Raspi/Xfce4" +
    "$d/46n7qR4vN/Jna2kS5BaSzckKD.0R0dkYTvcyoYR1" +
    "/OLWh4uV5eJ7UkFkgtLn/iTASNDqu7xyJz5rQ0gGgGr.";
}
