{ stdenv, fetchgit, dconf, glib, lib }:
stdenv.mkDerivation rec {
  name = "flat-remix-gnome";
  version = "20210623";

  buildInputs = [ dconf glib ];
  installPhase = ''
    # https://github.com/daniruiz/flat-remix-gnome/blob/master/Makefile#L54
    mkdir -p $out/share/gnome-shell/
    touch $out/share/gnome-shell/gnome-shell-theme.gresource
    make install PREFIX=$out
    rm $out/share/gnome-shell/gnome-shell-theme.gresource.old
  '';

  src = fetchgit {
    url = "https://github.com/daniruiz/flat-remix-gnome";
    rev = "${version}";
    fetchSubmodules = false;
    sha256 = "sha256-FKsbAvjhXb2ipe3XqACM6OwGYwbBbzvDjsUQYCIQ8NM=";
  };

  meta = with lib; {
    homepage = "https://github.com/daniruiz/flat-remix-gnome";
    license = with licenses; [ cc-by-nc-sa-40 ];
    maintainers = [ maintainers.vanilla ];
  };
}
