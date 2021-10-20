{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];

  # https://docs.hercules-ci.com/arion/#_nixos
  environment.systemPackages = with pkgs; [ arion docker-client ];
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;
  users.extraUsers."vanilla".extraGroups = [ "podman" ];
}
