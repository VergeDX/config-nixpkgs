{ stdenv, fetchurl, p7zip }:
stdenv.mkDerivation rec {
  name = "new-york";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
    sha256 = "sha256-qW/yCo4UPxz/MT7AXtK40pCjuf9gEKsGIZMldMn3lAI=";
  };

  buildInputs = [ p7zip ];
  unpackPhase = "7z x ${src}";
  installPhase = ''
    cd ./NYFonts
    7z x 'NY Fonts.pkg' && 7z x ./Payload~
    mkdir -p $out/share/fonts/opentype/
    cp -r ./Library/Fonts/ $out/share/fonts/opentype/NYFonts
  '';
}
