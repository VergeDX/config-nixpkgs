{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs, ... }: {
    # https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm
    nixosConfigurations."NixOS-Laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # modules = [ ./xmonad.nix ./users-nixosvmtest.nix ./systemPackages.nix ];
      modules = [{ services.dnscrypt-proxy2.enable = true; }] ++ [ ./anbox.nix ];
    };
  };
}
