{ stdenv, fetchgit, meson, pkg-config, cmake, glib, gtkmm3, libsecret, libxml2, libxslt, libuuid, gspell, unittest-cpp, python3, ninja, appimagekit, appstream-glib, desktop-file-utils, itstool, wrapGAppsHook, ... }:
stdenv.mkDerivation rec {
  pname = "gnote";
  version = "41.1";

  src = fetchgit {
    url = "https://github.com/GNOME/${pname}";
    rev = "${version}";
    hash = "sha256-12JSkpIBPaUQyeUJfqgDbvoFC9P/npnJIwnwAEhhftg=";
  };

  nativeBuildInputs = [ meson pkg-config cmake ninja ] ++ [ wrapGAppsHook ]
    ++ [ appimagekit appstream-glib desktop-file-utils itstool ];
  buildInputs = [ glib gtkmm3 libsecret libxml2 libxslt libuuid gspell unittest-cpp python3 ];
}
