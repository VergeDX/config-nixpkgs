{ inputs, pkgs, ... }:
{
  imports = [ ./boot.nix ] ++ [{ users.users."root".shell = pkgs.fish; }] ++
    [ "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-config.nix" ]
    ++ [ ./services/fail2ban.nix ./services/nginx.nix ] ++ [ inputs.agenix.nixosModules.age ];
  networking.hostName = "nixos";
}
