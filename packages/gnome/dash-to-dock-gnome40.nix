{ stdenv, fetchgit, glib, sassc }:
stdenv.mkDerivation rec {
  name = "dash-to-dock-gnome40";
  version = "58e1cd0";

  buildInputs = [ glib sassc ];
  src = fetchgit {
    url = "https://github.com/ewlsh/dash-to-dock";
    rev = "${version}e7b8d82a95e7c892c4efbeb2f7b2632f2";
    sha256 = "sha256-GnZaLQhm2chzygeodi4lpSh0VOIvZybIpdU9FGxGGFQ=";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
    cp -r * $out/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
  '';
}
