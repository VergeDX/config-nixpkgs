{ stdenvNoCC, fetchurl, unzip, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "AriaNg";
  version = "1.2.3";

  src = fetchurl {
    url = "https://github.com/mayswind/${pname}" +
      "/releases/download/${version}/${pname}-${version}-AllInOne.zip";
    hash = "sha256-GGIXVQDhWzsU7/jbTrovveTpSKHSqInvFDm/p9k87cM=";
  };

  nativeBuildInputs = [ unzip ];
  unpackPhase = "unzip ${src}";
  installPhase = "mkdir -p $out && cp * $_";
}
