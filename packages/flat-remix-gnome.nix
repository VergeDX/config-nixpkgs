let
  pkgs = import <nixpkgs> { };
  layan-gtk-theme = pkgs.stdenv.mkDerivation rec {
    name = "flat-remix-gnome";
    version = "20210524";

    buildInputs = [ pkgs.dconf pkgs.glib ];
    # buildPhase = "patchShebangs ./ && make PREFIX=$out";
    installPhase = ''
      # https://github.com/daniruiz/flat-remix-gnome/blob/master/Makefile#L54
      mkdir -p $out/share/gnome-shell/
      touch $out/share/gnome-shell/gnome-shell-theme.gresource
      make install PREFIX=$out
      rm $out/share/gnome-shell/gnome-shell-theme.gresource.old
    '';

    src = pkgs.fetchgit {
      url = "https://github.com/daniruiz/flat-remix-gnome";
      rev = "${version}";
      fetchSubmodules = false;
      sha256 = "sha256-FKoQ+coJlmd4Gm/dw032R3VdeQeE+PPPL5AJX2txMhw=";
    };
  };
in
layan-gtk-theme
