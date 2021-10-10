{ stdenv, fetchurl, unzip, ... }:
stdenv.mkDerivation rec {
  pname = "metro-for-steam";
  version = "4.4";

  folderName = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/minischetti/${pname}/archive/v${version}.zip";
    sha256 = "sha256-scj8Xnq9kGQx/0A+XVjNZkd754sohn5BXiaFXIubtoU=";
  };

  unpackPhase = "${unzip}/bin/unzip ${src}";
  installPhase = "mkdir -p $out && cp -r ${folderName} $out";
}
