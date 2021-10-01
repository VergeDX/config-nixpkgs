let
  # https://github.com/ryantm/agenix/issues/53
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHhc7Qz+qRW8HExnZfoCCErxbtDn/X0nSFDS6lPgmYX4 root@nixos";
  vanilla = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ//aL4yaW0iJychDr++qmE1/p73FkFpslQCUI3V00Tp osu_Vanilla@126.com";
  all = [ laptop vanilla ];
in
{
  "telegraf/INFLUX_TOKEN-env.age".publicKeys = all;
  "telegraf/config-env.age".publicKeys = all;
}
