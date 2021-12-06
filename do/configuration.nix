{ inputs, pkgs, ... }:
{
  imports = [ ./boot.nix ] ++ [{ users.users."root".shell = pkgs.fish; }] ++
    [ "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-config.nix" ]
    ++ [ ./services/fail2ban.nix ];
  networking.hostName = "nixos";
}
