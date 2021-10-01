let
  vanilla-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ//aL4yaW0iJychDr++qmE1/p73FkFpslQCUI3V00Tp osu_Vanilla@126.com";
  vanilla-raspi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKPU5IvilHjCrjW0ppXXrjzslTiCMpSBlLZjB89Z7Rb root@NixOS-Raspi";

  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHhc7Qz+qRW8HExnZfoCCErxbtDn/X0nSFDS6lPgmYX4 root@nixos";
  raspi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMpE4EHEYbzMiyiOvfXG4FBgyz5AhLW46WsRDEl90Rv osu_Vanilla@126.com";
  all = [ vanilla-laptop laptop vanilla-raspi raspi ];
in
{
  "telegraf/INFLUX_TOKEN-env.age".publicKeys = all;
  "telegraf/config-env.age".publicKeys = all;
}
