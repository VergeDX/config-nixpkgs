{ home, pkgs, ... }:
{
  home.file.".config/flutter/settings".text = ''{ "enable-linux-desktop": true }'';
  home.packages = [
    pkgs.android-studio
    pkgs.androidStudioPackages.canary
    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui

    pkgs.dart
    (pkgs.flutter.override (prev: {
      buildFHSUserEnv = { targetPkgs, ... }@args:
        prev.buildFHSUserEnv (args // {
          targetPkgs = p: with p;
            (targetPkgs p) ++ [
              pkgs.util-linux.dev
              pkgs.lzma.dev

              # GTK 3.0 & itals dependencies.
              pkgs.gtk3.dev
              pkgs.glib.dev
              pkgs.pango.dev
              pkgs.harfbuzz.dev
              pkgs.cairo.dev
              pkgs.gdk-pixbuf.dev
              pkgs.atk.dev

              # `flutter build linux` needs these.
              pkgs.pcre.dev
              pkgs.libffi.dev
              pkgs.freetype.dev
              pkgs.zlib.dev
              pkgs.libselinux.dev
              pkgs.libsepol.dev
              pkgs.bzip2.dev
              pkgs.libpng.dev
              pkgs.graphite2
              pkgs.fribidi
              pkgs.libthai.dev
              pkgs.libdatrie.dev
              pkgs.fontconfig.dev
              pkgs.expat.dev
              pkgs.pkgs.xorg.libXrender.dev
              pkgs.xlibs.xorgproto
            ];
        });
    }))
    pkgs.clang
    pkgs.cmake
    pkgs.ninja
    pkgs.pkg-config

    pkgs.jetbrains.rider
    pkgs.dotnet-sdk
    pkgs.mono
    pkgs.jetbrains.idea-ultimate
    pkgs.jdk11
    pkgs.kotlin
    pkgs.jetbrains.goland
    pkgs.go
    pkgs.jetbrains.pycharm-professional
    pkgs.python3Full
    pkgs.jetbrains.clion
    pkgs.cmake
    pkgs.gnumake

    pkgs.maven
    pkgs.gradle
  ];
}
