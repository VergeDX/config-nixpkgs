{ ... }:
{
  # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;
  users.users."vanilla".extraGroups = [ "docker" ];
}
