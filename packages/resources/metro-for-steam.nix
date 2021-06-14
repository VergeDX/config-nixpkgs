{ stdenv, fetchurl, unzip }:
stdenv.mkDerivation rec {
  name = "metro-for-steam";
  version = "4.4";
  folderName = "${name}-${version}";

  src = fetchurl {
    url = "https://github.com/minischetti/${name}/archive/v${version}.zip";
    sha256 = "sha256-scj8Xnq9kGQx/0A+XVjNZkd754sohn5BXiaFXIubtoU=";
  };

  buildInputs = [ unzip ];
  unpackPhase = "unzip ${src}";
  installPhase = "mkdir -p $out && cp -r ${folderName} $out/${folderName}";
}
