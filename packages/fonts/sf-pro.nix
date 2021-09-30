{ stdenv, fetchurl, p7zip }:
stdenv.mkDerivation rec {
  name = "sf-pro";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-Q2QgwnxNFf+zzLbZ/gF2uvE3TZpapmQTUY4enMmMCOM=";
  };

  buildInputs = [ p7zip ];
  unpackPhase = "7z x ${src}";
  installPhase = ''
    cd ./SanFranciscoPro/
    7z x 'San Francisco Pro.pkg' && 7z x ./Payload~
    mkdir -p $out/share/fonts/opentype/
    cp -r ./Library/Fonts/ $out/share/fonts/opentype/SF-Pro
  '';
}
