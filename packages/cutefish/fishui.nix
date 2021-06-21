{ pkgs, ... }:
let
  cutefishos-fishui = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-fishui";
    version = "0.2-1";

    src = pkgs.fetchurl {
      url = "https://mirror.pseudoform.org/community/os/x86_64/fishui-${version}-x86_64.pkg.tar.zst";
      sha256 = "sha256-Au0SCT6B9mEF+1RXDip/jdfIz7ryCo9n6ZdRCojZ+oY=";
    };

    installPhase = ''
      mkdir -p $out/lib/ && cp -r ./lib/ $out
      cd $out/lib/ && mv ./qt/ ./qt-5.15.2/
    '';
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [
      pkgs.zstd
      pkgs.libsForQt5.wrapQtAppsHook
      pkgs.libsForQt5.kwindowsystem
    ];
  };
in
cutefishos-fishui
