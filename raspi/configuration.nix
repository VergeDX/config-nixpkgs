{ pkgs, lib, self, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./networking/wireless.nix
    ./networking/networkmanager.nix
    ./networking/hostName-domain.nix

    ./users-immutable.nix
    ./boot.nix

    ./services/openssh.nix
  ] ++ [ "${self}/modules/nixFlakes.nix" ];
  nixFlakes.enable = true;

  environment.systemPackages = with pkgs; [ git ];
  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
