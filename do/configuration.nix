{ inputs, ... }:
{
  imports = [ ./users.nix ./boot.nix ] ++
    [ "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix" ];
}
