{ stdenv, fetchurl, zstd, ... }:
stdenv.mkDerivation rec {
  name = "cutefish-icons";
  version = "0.2-1";

  src = fetchurl {
    url = "https://mirror.pseudoform.org/community/os/x86_64/${name}-${version}-any.pkg.tar.zst";
    sha256 = "sha256-jw8k99ZkfI9kGOZQDg4qt6BlXa9Ni33xq+Sv2FKwAp8=";
  };

  installPhase = "mkdir $out && cp -r share $out";
  buildInputs = [ zstd ];
}
