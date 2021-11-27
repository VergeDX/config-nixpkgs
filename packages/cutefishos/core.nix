{ stdenv, fetchgit, cmake, libsForQt5, pkg-config, pkgs, xorg, fetchurl, callPackage, ... }:
# https://github.com/NixOS/nixpkgs/pull/95412
let appmenu-gtk3-module-nix = fetchurl {
  url = "https://raw.githubusercontent.com/LouisDK1/nixpkgs/e1b510cf28c4d11d50261e57d429aa2b1dd2ef4a"
    + "/pkgs/development/libraries/appmenu-gtk3-module/default.nix";
  hash = "sha256-wb6x3EUam9FahJi5v3Yp4PcMCahDchyL96vf7Tme3H0=";
}; in
let appmenu-gtk3-module = callPackage appmenu-gtk3-module-nix { }; in
let appmenu-gtk-module = appmenu-gtk3-module.overrideAttrs (old: {
  # pkgs/development/libraries/appmenu-gtk3-module/default.nix - L48
  preConfigure = "";

  buildInputs = old.buildInputs ++ [ pkgs.gtk2 ];
  PKG_CONFIG_GTK__2_0_LIBDIR = old.PKG_CONFIG_GTK__3_0_LIBDIR;
}); in
stdenv.mkDerivation rec {
  pname = "core";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/${pname}";
    rev = "${version}";
    hash = "sha256-89r1Xehjc/DOk3ZOwWZhe2LhPMxvJSADuHAlXVr/eBg=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = with libsForQt5;
    [ qtbase qtdeclarative qtquickcontrols2 qtx11extras qttools ]
    ++ [ pkgs.polkit libsForQt5.polkit-qt ]
    ++ (with pkgs; [ pcre libuuid libselinux libsepol ])
    ++ [ libsForQt5.kwindowsystem pkgs.libpulseaudio ]
    ++ (with xorg; [ libXdmcp xf86inputlibinput xorgserver ])
    ++ (with pkgs; [ libGL_driver.dev valgrind xorg.xf86inputsynaptics ])
    ++ [ xorg.libSM appmenu-gtk-module libsForQt5.kcoreaddons ]
    ++ (with xorg; [ libXtst libXcursor ]);

  dontWrapQtApps = true;

  # https://github.com/cutefishos/core/blob/0.5/CMakeLists.txt#L36
  # https://github.com/cutefishos/core/blob/0.5/notificationd/CMakeLists.txt#L32
  patchPhase = ''
    sed -i 's@/etc@etc@g' CMakeLists.txt
    sed -i 's@/usr/@@g' notificationd/CMakeLists.txt
  '';

  cmakeFlags = [ "-Wno-dev" ];
}
