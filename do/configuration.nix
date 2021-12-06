{ inputs, pkgs, ... }:
{
  imports = [ ./boot.nix ] ++ [{ users.users."root".shell = pkgs.fish; }] ++
    [ "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-config.nix" ];
}
