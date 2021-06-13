{ stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  name = "sf-mono";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "sha256-7AUY4xB5fS+cuSTBjj57ZhNZ9PtlPRrUMVdY6821/xE=";
  };

  buildInputs = [ p7zip ];
  unpackPhase = "7z x ${src}";
  installPhase = ''
    cd ./SFMonoFonts
    7z x 'SF Mono Fonts.pkg' && 7z x ./Payload~
    mkdir -p $out/share/fonts/opentype/
    cp -r ./Library/Fonts/ $out/share/fonts/opentype/SFMonoFonts
  '';
}
