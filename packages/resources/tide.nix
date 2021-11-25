{ stdenv, fetchgit, ... }:
stdenv.mkDerivation rec {
  pname = "tide";
  version = "5.0.1";

  src = fetchgit {
    url = "https://github.com/IlanCosman/${pname}";
    rev = "v${version}";
    hash = "sha256-EjEVyWwAtVqPFDEo9QUUAQXlAMlmEmaO0sqmjZSKI5M=";
  };

  buildPhase = "echo";
  installPhase = "mkdir $out/ && cp -r * $out/";
}
