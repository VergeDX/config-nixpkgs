{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";

    # https://github.com/nix-community/nixos-generators#using-in-a-flake
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.x86_64-linux = {
      vanilla-do = nixos-generators.nixosGenerate {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # https://docs.digitalocean.com/products/images/custom-images/#image-requirements
        modules = [ ./services/cloud-init.nix ./services/openssh.nix ];
        format = "do";
      };
    };
  };
}
