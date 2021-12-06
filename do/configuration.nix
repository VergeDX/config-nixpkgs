{ inputs, pkgs, ... }:
{
  imports = [ ./boot.nix ] ++ [{ users.users."root".shell = pkgs.fish; }] ++
    [ "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-config.nix" ]
    ++ [ ./services/fail2ban.nix ./services/nginx.nix ./services/v2ray.nix ]
    ++ [ inputs.agenix.nixosModules.age ];

  networking.hostName = "nixos";
  age.secrets."v2ray/id".file = ./secrets/v2ray/id.age;
}
