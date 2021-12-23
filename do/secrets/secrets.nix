let
  do = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFinlLkZWFaLWikjDH1/q+TeGgkEx2vs4QKRdbX9BRpq";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHhc7Qz+qRW8HExnZfoCCErxbtDn/X0nSFDS6lPgmYX4";
  vanilla = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVpgJtK1tTpURq6XH3xibH+6VdU8/2igxpQs4aAkaoy";
  all = [ do laptop vanilla ];
in
{
  "v2ray/id.age".publicKeys = all;
  "v2ray/path.age".publicKeys = all;
}
