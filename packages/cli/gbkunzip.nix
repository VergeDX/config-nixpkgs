{ stdenv, fetchurl, ... }:
stdenv.mkDerivation rec {
  name = "gbkunzip";
  version = "0.2-6";

  src = fetchurl {
    url = "https://blog.lilydjwg.me/user_files/lilydjwg/File/gbkunzip.tar.bz2";
    hash = "sha256-xGWNGfKT/gAPUTPuIBbLkpQD0KakFBwz03ASqr7k5f4=";
  };

  unpackPhase = "tar -xf ${src}";
  installPhase = ''
    mkdir -p $out/bin && cp ./gbkunzip $_
    mkdir -p $out/lib/python3.9/site-packages
    cp ./gbzip.py $_
  '';
}
