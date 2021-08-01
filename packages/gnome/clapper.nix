{ stdenv
, fetchFromGitHub
, pkgs
}:
stdenv.mkDerivation rec {
  name = "clapper";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "Rafostar";
    repo = name;
    rev = version;
    sha256 = "sha256-uc2+AWpG2BtVrX7uFdjDDQOtiqKzVe4ZDH9DL60Zdj8=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    python3
    pkg-config
    cmake
    buildPackages.shared-mime-info
    desktop-file-utils
    ninja
    wrapGAppsHook
  ];

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/doc/languages-frameworks/gnome.section.md
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
  # preFixup = "gappsWrapperArgs+=(--argv0 com.github.rafostar.Clapper)";

  buildInputs = with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    libGL
    xlibs.libX11
    wayland
    gobject-introspection
    gtk4
    gjs
    glib
    libsoup

    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
  ];

  # https://github.com/NixOS/nixpkgs/issues/36468
  mesonFlags = [ "-Dc_args=-I${pkgs.glib.dev}/include/gio-unix-2.0" ];
  # https://unix.stackexchange.com/questions/555802/in-nix-how-can-i-build-a-package-that-has-a-python-post-install-script
  postPatch = "patchShebangs build-aux/meson/postinstall.py";
  # https://nixos.org/manual/nixpkgs/stable/#sec-stdenv-phases
  fixupPhase = ''
    wrapGAppsHook
    ln -s $out/share/com.github.rafostar.Clapper $out/share/.com.github.rafostar.Clapper-wrapped
  '';

  meta = with pkgs.lib; {
    description = "A GNOME media player built using GJS with GTK4 toolkit and powered by GStreamer with OpenGL rendering.";
    homepage = "https://github.com/Rafostar/clapper";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = [ maintainers.vanilla ];
  };
}
