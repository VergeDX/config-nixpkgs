{ stdenv, fetchurl, buildFHSUserEnv, ... }:
let tdesktop-bin = stdenv.mkDerivation {
  pname = "tdesktop-bin";
  version = "3.2.5";

  src = fetchurl {
    url = "https://github.com/telegramdesktop/tdesktop/releases/download/v3.2.5/tsetup.3.2.5.tar.xz";
    hash = "sha256-ggFYEvYzS9XI7lYgSpRs8KJzROSM6fRL/4fQ3D+E7wM=";
  };

  installPhase = "mkdir -p $out/bin/ && cp ./Telegram $out/bin/";
}; in
buildFHSUserEnv {
  name = "${tdesktop-bin.pname}";
  targetPkgs = pkgs: [ tdesktop-bin ] ++
    (with pkgs; [ glib fontconfig freetype ]) ++
    (with pkgs.xlibs; [ libxcb libX11 ]) ++
    # https://wayland-devel.freedesktop.narkive.com/wtyneVJL/weston-launch-xkbcommon-error
    [ pkgs.dbus pkgs.xkeyboard_config ];
  runScript = "Telegram";
}
