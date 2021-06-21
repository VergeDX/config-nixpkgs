{ pkgs, ... }:
let
  cutefish-settings = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-settings";
    version = "0.2-1";

    src = pkgs.fetchurl {
      url = "https://mirror.pseudoform.org/community/os/x86_64/${name}-${version}-x86_64.pkg.tar.zst";
      sha256 = "sha256-/3WN/mcQJKD/xb5GnQgoL1jndEixM4AhRFzBRTVCy2I=";
    };

    installPhase = "mkdir $out && cp -r bin share $out";
    nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.zstd
      pkgs.libsForQt5.kcoreaddons
      (pkgs.libxcrypt.overrideAttrs (old: {
        fixupPhase = "cd $out/lib && ln -s libcrypt.so libcrypt.so.2";
      }))

      pkgs.libsForQt5.qt5.qtquickcontrols2
      (pkgs.callPackage ./fishui.nix { })
      pkgs.libsForQt5.qt5.qtgraphicaleffects
      (pkgs.callPackage ./libcutefish.nix { })
    ];
  };
in
cutefish-settings
