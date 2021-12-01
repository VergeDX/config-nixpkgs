{ stdenv, fetchurl, dpkg, buildFHSUserEnv, ... }:
let baidunetdisk = stdenv.mkDerivation rec {
  pname = "baidunetdisk";
  version = "3.5.0";

  src = fetchurl {
    url = "https://issuecdn.baidupcs.com/issue/netdisk/LinuxGuanjia"
      + "/${version}/${pname}_${version}_amd64.deb";
    hash = "sha256-rtCpX0Fi4X2IFZ7Qc2Y2+kf0mvMT0IIGR69GDfT9SbY=";
  };

  nativeBuildInputs = [ dpkg ];
  unpackPhase = "dpkg-deb -x ${src} .";
  installPhase = "mkdir $out && cp -r * $out";
}; in
buildFHSUserEnv {
  name = "${baidunetdisk.pname}";
  targetPkgs = pkgs: [ pkgs.glib ] ++ (with pkgs.xlibs; [ libX11 libxcb libXcomposite libXcursor libXdamage libXext libXfixes libXi libXrender libXtst ]) ++ (with pkgs; [ nss nspr atk at_spi2_atk dbus_daemon gdk-pixbuf gtk3-x11 gnome2.pango cairo ]) ++ (with pkgs.xlibs; [ libXrandr ]) ++ (with pkgs; [ expat libdrm libGL_driver ]) ++ (with pkgs; [ xlibs.libXScrnSaver alsa-lib at_spi2_core cups ]) ++ (with pkgs; [ ]);

  runScript = "${baidunetdisk}/opt/${baidunetdisk.pname}/${baidunetdisk.pname}";
}
