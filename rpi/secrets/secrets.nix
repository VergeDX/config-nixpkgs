let
  vanilla-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ//aL4yaW0iJychDr++qmE1/p73FkFpslQCUI3V00Tp osu_Vanilla@126.com";
  vanilla-raspi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOkOC5QHENPGhZlQcqPnXuaFvPY8N1EkhKBgAjIWOGe osu_Vanilla@126.com";

  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHhc7Qz+qRW8HExnZfoCCErxbtDn/X0nSFDS6lPgmYX4 root@nixos";
  raspi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDdByMiIWa9q/YW8G86q6jmb1xpNeKkv1QTrWHJf151Y root@NixOS-Raspi";
  all = [ vanilla-laptop laptop vanilla-raspi raspi ];
in
{
  "telegraf/INFLUX_TOKEN-env.age".publicKeys = all;
  "telegraf/config-env.age".publicKeys = all;
}
