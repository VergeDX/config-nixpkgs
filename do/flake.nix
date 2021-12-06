{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";

    # https://github.com/nix-community/nixos-generators#using-in-a-flake
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, nixos-generators, deploy-rs, ... }: {
    packages.x86_64-linux = {
      do = nixos-generators.nixosGenerate {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # https://docs.digitalocean.com/products/images/custom-images/#image-requirements
        modules = [ ./services/cloud-init.nix ./services/openssh.nix ] ++ [ ./users.nix ];
        format = "do";
      };
    };

    deploy.nodes."nixos" = rec {
      hostname = "134.209.111.162";
      sshUser = "root";

      profiles.system = {
        user = "${sshUser}";
        path = deploy-rs.lib."x86_64-linux".activate.nixos (nixpkgs.lib.nixosSystem
          { system = "x86_64-linux"; modules = [ ./configuration.nix ]; });
        fastConnection = true;
      };
    };
  };
}
