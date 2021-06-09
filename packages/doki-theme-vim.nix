let
  pkgs = import <nixpkgs> { };
  doki-theme-vim = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "doki-theme-vim";
    version = "v8.0.0";
    pkadd-name = "${pname}-${version}";

    src = pkgs.fetchgit {
      url = "https://github.com/doki-theme/doki-theme-vim";
      rev = "${version}";
      sha256 = "sha256-1glc0Kao1f+omvS1RNvztNS9tOdtFE63R1GzefSCgR0=";
    };
  };
in
doki-theme-vim
