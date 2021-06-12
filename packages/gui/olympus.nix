{ pkgs, makeDesktopItem }:
let
  # pkgs = import <nixpkgs> { };
  olympus = pkgs.stdenv.mkDerivation rec {
    pname = "olympus";
    version = "2134";

    # https://everestapi.github.io/
    src = pkgs.fetchzip {
      url = "https://dev.azure.com/EverestAPI/Olympus/_apis/build/builds/${version}/artifacts?artifactName=linux.main&$format=zip#linux.main.zip";
      sha256 = "sha256-F23S1pWgCwlkGJWnaFKdVP3QAxyDnL8x1xhqI14NVaA=";
    };

    buildInputs = [ pkgs.unzip ];
    installPhase = ''
      mkdir -p "$out/opt/olympus/"
      mv dist.zip "$out/opt/olympus/" && cd "$out/opt/olympus/"

      unzip dist.zip && rm dist.zip
      mkdir $out && echo XDG_DATA_HOME=$out

      echo y | XDG_DATA_HOME="$out/share/" bash install.sh
      sed -i "/ldconfig/d" ./love && rm ./usr/lib/libSDL2-2.0.so.0
      sed -i "s/Exec=.*/Exec=olympus %u/g" ../../share/applications/Olympus.desktop
    '';
  };
in
pkgs.buildFHSUserEnv {
  name = "olympus";
  runScript = "${olympus}/opt/olympus/olympus";
  targetPkgs = pkgs: [
    pkgs.freetype
    pkgs.zlib
    pkgs.SDL2
    pkgs.curl
    pkgs.libpulseaudio
    pkgs.gtk3
    pkgs.glib
  ];

  # https://github.com/EverestAPI/Olympus/blob/main/lib-linux/olympus.desktop
  # https://stackoverflow.com/questions/8822097/how-to-replace-a-whole-line-with-sed
  extraInstallCommands = ''cp -r "${olympus}/share/" $out'';
}
