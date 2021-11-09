{ pkgs, ... }:
{
  users.mutableUsers = false;
  users.users."root".shell = pkgs.fish;
}
