{ pkgs, ... }:
let
  # pkgs = import <nixpkgs> { };
  startrinity = pkgs.stdenv.mkDerivation rec {
    name = "startrinity";
    src = pkgs.fetchurl {
      url = "http://${name}.com/InternetQuality/${name}_cst_linux_x64.tar.gz";
      sha256 = "sha256-RF8hIyvzEDbvAmiGJGqKsut1wUgdVJ7WpkHWnNThuSQ=";
    };

    unpackPhase = "tar -xf ${src}";
    installPhase = ''
      mkdir -p $out && cp -r * $out
    '';

    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [
      pkgs.zlib
      pkgs.lttng-ust
      pkgs.gcc-unwrapped.lib
      pkgs.curl
    ];
  };
in
pkgs.buildFHSUserEnv {
  name = startrinity.name;
  targetPkgs = pkgs: [ pkgs.openssl.dev ];
  runScript = "${startrinity.out}/CST.CrossPlatform";
}
