{ stdenv
, fetchFromGitHub
, lib
}:

stdenv.mkDerivation rec {
  pname = "layan-gtk-theme";
  version = "2021-06-30";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = pname;
    rev = version;
    sha256 = "sha256-FI8+AJlcPHGOzxN6HUKLtPGLe8JTfTQ9Az9NsvVUK7g=";
  };

  installPhase = ''
    patchShebangs .
    mkdir -p $out/share/themes
    ./install.sh -d $out/share/themes -n Layan
  '';

  meta = with lib; {
    description = "A flat Material Design theme for GTK 3, GTK 2 and Gnome-Shell.";
    homepage = "https://github.com/vinceliuice/Layan-gtk-theme";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.vanilla ];
  };
}
