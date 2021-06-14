# https://nixos.wiki/wiki/Node.js

{ mkYarnPackage, fetchgit }:
mkYarnPackage rec {
  name = "pxder-v2.12.5";
  src = fetchgit {
    url = "https://github.com/Tsuk1ko/pxder";
    rev = "v2.12.5";
    sha256 = "sha256:0b6n54z3p423gidy720wmrzvq5xcddzyvnw75w377nhyxq86s2fa";
  };

  packageJSON = "${src}/package.json";
  yarnLock = "${src}/yarn.lock";
  yarnNix = ./yarn.nix;
}
