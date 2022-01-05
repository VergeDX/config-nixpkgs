{ stdenv, requireFile, p7zip, wimlib, fontforge, ... }:
stdenv.mkDerivation rec {
  pname = "Win10_LTSC_2019_fonts";
  version = "LTSC_2019";

  src = requireFile {
    name = "cn_windows_10_enterprise_ltsc_2019_x64_dvd_9c09ff24.iso";
    sha256 = "aa4ea00581aa84999dbfe0627499b392e10c75912d6e2f1635eb7c4b9139fb5f";
    url = "https://msdn.itellyou.cn/"; # TODO: LTSC 2021
  };

  nativeBuildInputs = [ p7zip wimlib fontforge ];
  unpackPhase = "7z x ${src}";

  # https://wimlib.net/man1/wimextract.html
  buildPhase = ''
    cd ./sources/ && mkdir install && mv install.wim install
    cd install && wimextract install.wim 1 /Windows/Fonts
  '';

  # https://forums.techguy.org/threads/convert-font-file-fon-to-another-format.654200/
  # https://stackoverflow.com/questions/13087903/command-line-tool-for-converting-ttf-otf-fonts-to-svg
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/ && find . -name "*.ttf" -exec cp {} $_ \;
    mkdir -p $out/share/fonts/opentype/ && find . -name "*.ttc" -exec cp {} $_ \;

    mkdir -p $out/share/fonts/misc/ && cd ./Fonts
    rm ./script.fon ./roman.fon ./modern.fon

    for fon_font in $(find . -name "*.fon"); do
      file_name="$(basename $fon_font .fon)"

      fontforge -c "import fontforge; \
        fontforge.open(\"$fon_font\").generate(\"$file_name.bdf\")"
    done

    mkdir -p $out/share/fonts/misc/ && cp -r ./*.bdf $out/share/fonts/misc/
  '';
}
