{
  packageOverrides = pkgs: {
    # https://github.com/nix-community/NUR#installation
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
}
