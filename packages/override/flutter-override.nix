{ pkgs }:
let linkShareToLib = ''
  cd $out && mkdir lib
  ln -s ../share/pkgconfig/ ./lib
'';
in
pkgs.flutter.override (prev: {
  buildFHSUserEnv = { targetPkgs, ... }@args:
    prev.buildFHSUserEnv (args // {
      targetPkgs = p: with p; (targetPkgs p) ++ [
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

        (pkgs.xlibs.xorgproto.overrideAttrs (old: { fixupPhase = linkShareToLib; }))

        pkgs.xlibs.libX11.dev
        pkgs.xlibs.libxcb.dev
        pkgs.xlibs.libXau.dev
        pkgs.xlibs.libXdmcp.dev
        pkgs.xlibs.libXft.dev
        pkgs.xlibs.pixman
        pkgs.libGL.dev
        pkgs.xlibs.libXext.dev
        pkgs.libtiff.dev
        pkgs.xlibs.libXi.dev
        pkgs.xlibs.libXfixes.dev
        pkgs.xlibs.libXrandr.dev
        pkgs.xlibs.libXcursor.dev
        pkgs.xlibs.libXcomposite.dev
        pkgs.xlibs.libXinerama.dev
        pkgs.wayland-scanner.dev

        (pkgs.wayland-protocols.overrideAttrs (old: { fixupPhase = linkShareToLib; }))

        pkgs.libxkbcommon.dev
        pkgs.epoxy.dev
        pkgs.at_spi2_atk
        pkgs.dbus_libs.dev
        pkgs.at_spi2_core.dev
      ];
    });
})
