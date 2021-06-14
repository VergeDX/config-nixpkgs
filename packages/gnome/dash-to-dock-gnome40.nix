{ stdenv, fetchgit, glib, sassc }:
stdenv.mkDerivation rec {
  name = "dash-to-dock-gnome40";
  version = "a2d40e2";

  buildInputs = [ glib sassc ];
  src = fetchgit {
    url = "https://github.com/ewlsh/dash-to-dock";
    rev = "${version}a06117617bcbc5f85608c895c7734604e";
    sha256 = "sha256-Kb4TlZAjXu7M/xL9maTZgJT19+PCopB5U9ZRXeaN/mM=";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
    cp -r * $out/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
  '';
}
