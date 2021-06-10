{ vimUtils, fetchgit }:
vimUtils.buildVimPluginFrom2Nix rec {
  pname = "doki-theme-vim";
  version = "v8.0.0";
  pkadd-name = "${pname}-${version}";

  src = fetchgit {
    url = "https://github.com/doki-theme/doki-theme-vim";
    rev = "${version}";
    sha256 = "sha256-1glc0Kao1f+omvS1RNvztNS9tOdtFE63R1GzefSCgR0=";
  };
}
