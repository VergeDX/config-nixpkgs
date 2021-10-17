{ ... }:
{
  users.users.nixosvmtest.isNormalUser = true;
  # https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm
  users.users."nixosvmtest".initialHashedPassword = "test";
}
