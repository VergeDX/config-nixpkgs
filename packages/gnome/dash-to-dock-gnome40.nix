{ stdenv, fetchgit, glib, sassc }:
stdenv.mkDerivation rec {
  name = "dash-to-dock-gnome40";
  version = "e4beec8";

  buildInputs = [ glib sassc ];
  src = fetchgit {
    url = "https://github.com/ewlsh/dash-to-dock";
    rev = "${version}47181e4163b0a99ceaef4c4582cc8ae4c";
    sha256 = "sha256-7UVnLXH7COnIbqxbt3CCscuu1YyPH6ax5DlKdaHCT/0=";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
    cp -r * $out/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
  '';
}
