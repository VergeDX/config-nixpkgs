{ inputs, pkgs, ... }:
{
  imports = [ ./boot.nix ] ++ [{ users.users."root".shell = pkgs.fish; }] ++
    [ "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-config.nix" ]
    ++ [ ../virmach/services/fail2ban.nix ];
  networking.hostName = "nixos";
}
