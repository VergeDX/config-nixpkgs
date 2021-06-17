{ stdenv, fetchurl, pkgs }: with pkgs;
stdenv.mkDerivation rec {
  name = "google-earth-pro";
  version = "7.3.3";

  src = fetchurl {
    url = "https://dl.google.com/dl/linux/direct/${name}-stable_${version}_amd64.deb";
    sha256 = "sha256-Y60v2uVc76dnTmii9zgydKF2itEYwTzGE+C4l/lUbOg=";
  };

  unpackPhase = "dpkg-deb -x ${src} $out || true";
  installPhase = ''
    mkdir -p $out/share/applications/ && cd $out/opt/google/earth/pro/
    # https://stackoverflow.com/questions/584894/environment-variable-substitution-in-sed
    sed -i 's@Exec=@Exec='"$out"'@g' ./google-earth-pro.desktop
    unlink ./google-earth-pro && ln -s $out/opt/google/earth/pro/googleearth ./google-earth-pro
    ln -s $out/opt/google/earth/pro/google-earth-pro.desktop $out/share/applications/

    find $out -name 'libQt*' -exec rm {} \;
    for bin in googleearth-bin gpsbabel repair_tool;do
      wrapProgram $out/opt/google/earth/pro/$bin \
        "''${qtWrapperArgs[@]}" \
        --set QT_AUTO_SCREEN_SCALE_FACTOR 1
    done
  '';
  buildInputs = [
    pkgs.dpkg
    pkgs.autoPatchelfHook
    pkgs.libsForQt5.full

    pkgs.gst_all_1.gst-plugins-base
    pkgs.libGLU
    pkgs.alsaLib
    pkgs.libproxy
    pkgs.cups.lib
  ];
  nativeBuildInputs = [ pkgs.libsForQt5.wrapQtAppsHook ];
}
