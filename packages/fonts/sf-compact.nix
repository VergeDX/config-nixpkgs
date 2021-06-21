{ stdenv, fetchurl, p7zip }:
stdenv.mkDerivation rec {
  name = "sf-compact";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
    sha256 = "sha256-6dn4J0/fDR8+vR64paBIePuRcmMgi3oJ4ieRJa2CJPU=";
  };

  buildInputs = [ p7zip ];
  unpackPhase = "7z x ${src}";
  installPhase = ''
    cd ./SanFranciscoCompact
    7z x 'San Francisco Compact.pkg' && 7z x ./Payload~
    mkdir -p $out/share/fonts/opentype/
    cp -r ./Library/Fonts/ $out/share/fonts/opentype/SanFranciscoCompact
  '';
}