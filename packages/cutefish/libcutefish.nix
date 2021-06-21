{ pkgs, ... }:
let
  libcutefish = pkgs.stdenv.mkDerivation rec {
    name = "libcutefish";
    version = "0.2-1";

    src = pkgs.fetchurl {
      url = "https://mirror.pseudoform.org/community/os/x86_64/${name}-${version}-x86_64.pkg.tar.zst";
      sha256 = "sha256-sLFIvXk5TPwDAya/ak2goYxkOf65RvJJztDli/ImF24=";
    };

    installPhase = ''
      mkdir -p $out/lib/ && cp -r ./lib/ $out
      cd $out/lib/ && mv ./qt/ ./qt-5.15.2/
    '';
    nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.zstd
      pkgs.libsForQt5.kcoreaddons
      pkgs.libsForQt5.libkscreen
      pkgs.libsForQt5.qt5.qtsensors
      pkgs.libsForQt5.networkmanager-qt
    ];
  };
in
libcutefish
