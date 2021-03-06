let
  vanilla = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVpgJtK1tTpURq6XH3xibH+6VdU8/2igxpQs4aAkaoy";
  nixos-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHhc7Qz+qRW8HExnZfoCCErxbtDn/X0nSFDS6lPgmYX4";
  all = [ vanilla nixos-laptop ];
in
{
  # https://justarchinet.github.io/ASF-WebConfigGenerator/#/bot
  "Steam/SteamLogin.age".publicKeys = all;
  "Steam/SteamPassword.age".publicKeys = all;

  # https://wakatime.com/terminal
  "dot-wakatime-cfg.age".publicKeys = all;
  "dot-sg_cli.age".publicKeys = all;

  # https://cloud.drone.io/account
  "DRONE_TOKEN.age".publicKeys = all;

  "TICK/INFLUX_TOKEN.age".publicKeys = all;
}
