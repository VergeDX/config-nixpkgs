{ stdenv }:
stdenv.mkDerivation rec {
  name = "ms-fonts";

  # Extract from "cn_windows_10_consumer_editions_version_21h1_x64_dvd_1baf479d.iso".
  # Telegram: @My_Aim_Sucks
  src = ../MS-Fonts.tar.gz;
  installPhase = ''
    mkdir -p $out/share/fonts/opentype/${name}
    cp * $out/share/fonts/opentype/${name}/
  '';
}
