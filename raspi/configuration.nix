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
    ./services/fail2ban.nix
    ./services/samba.nix

    ./fileSystems.nix
  ] ++ [ "${self}/modules/nixFlakes.nix" ];
  nixFlakes.enable = true;
}
