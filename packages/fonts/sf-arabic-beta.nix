{ stdenv, fetchurl, p7zip }:
stdenv.mkDerivation rec {
  name = "sf-arabic-beta";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Arabic.dmg";
    sha256 = "sha256-DI76Da0L+J56z7OHGTudo76PWEFUYuE1i5lxK/xiB6o=";
  };

  buildInputs = [ p7zip ];
  unpackPhase = "7z x ${src}";
  installPhase = ''
    cd ./SFArabicFonts
    7z x 'SF Arabic Fonts.pkg' && 7z x ./Payload~
    mkdir -p $out/share/fonts/opentype/
    cp -r ./Library/Fonts/ $out/share/fonts/opentype/SFArabicFonts
  '';
}
