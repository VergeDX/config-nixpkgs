{ stdenv, fetchgit, ... }:
stdenv.mkDerivation rec {
  pname = "rose-pine-fish";
  version = "f29ecc9";

  src = fetchgit {
    url = "https://github.com/rose-pine/fish";
    rev = "${version}c28296b19d1c068892aee283a9b9e2257";
    hash = "sha256-64TqA6fV3lUqgRQg0s1D2krjip+bQ9n4NwlyMrEivQ0=";
  };

  installPhase = "mkdir $out/ && cp ./rose_pine.fish $out/";
}
