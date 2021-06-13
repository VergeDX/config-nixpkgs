{ stdenv, fetchurl, p7zip }:
stdenv.mkDerivation rec {
  name = "sf-arabic-beta";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Arabic.dmg";
    sha256 = "sha256-WyjSx+xVczdapeSsXEs8SKrYb0ilWa+W6Ei0SEIquxI=";
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
