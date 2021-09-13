{ pkgs
, fetchFromGitHub
, meson
, pkg-config
, cmake
, gst_all_1
, libGL
, xlibs
, wayland-scanner
, gobjectIntrospection
, gtk4
, gjs
, python3
, appstream-glib
, ninja
, glib
, shared_mime_info
, desktop_file_utils
, wrapGAppsHook
, libadwaita
, libsoup
, lib
}:
pkgs.stdenv.mkDerivation rec {
  pname = "clapper";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "Rafostar";
    repo = pname;
    rev = version;
    sha256 = "sha256-GSqBXATQywRW5IKXkAqmP9WpuPe9Txp7iD2XFWn6xL0=";
  };

  patchPhase = "patchShebangs build-aux/meson/postinstall.py";

  nativeBuildInputs = [ meson pkg-config cmake ninja wrapGAppsHook ];
  buildInputs = with gst_all_1; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    libGL
    xlibs.libX11
    wayland-scanner.dev
    gobjectIntrospection
    gtk4
    gjs
    python3
    appstream-glib

    shared_mime_info
    desktop_file_utils

    libadwaita
    libsoup
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];

  # TODO: https://github.com/NixOS/nixpkgs/issues/36468
  mesonFlags = [ "-Dc_args=-I${glib.dev}/include/gio-unix-2.0" ];

  postInstall = ''
    cp ${src}/data/icons/*.svg $out/share/icons/hicolor/scalable/apps/
    cp ${src}/data/icons/*.svg $out/share/icons/hicolor/symbolic/apps/
  '';

  meta = with lib; {
    description = "A GNOME media player built using GJS with GTK4 toolkit and powered by GStreamer with OpenGL rendering.";
    homepage = "https://github.com/Rafostar/clapper";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.vanilla ];
  };
}
