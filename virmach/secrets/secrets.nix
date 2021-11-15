let
  virmach = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFs/UzFVQ8gqAPhffapZFaZdcABe2NXTAeAsIfkSDUoU";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHhc7Qz+qRW8HExnZfoCCErxbtDn/X0nSFDS6lPgmYX4";
  vanilla = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVpgJtK1tTpURq6XH3xibH+6VdU8/2igxpQs4aAkaoy";
  all = [ virmach laptop vanilla ];
in
{
  "v2ray/id.age".publicKeys = all;
  "v2ray/secret.age".publicKeys = all;

  "asf/SteamLogin.age".publicKeys = all;
  "asf/SteamPassword.age".publicKeys = all;

  "telegraf/INFLUX_TOKEN-env.age".publicKeys = all;
  "telegraf/config_url/system.age".publicKeys = all;
}
