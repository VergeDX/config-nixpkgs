{ stdenvNoCC, fetchgit, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "multi-monitors-add-on";
  version = "0b54630";

  src = fetchgit {
    url = "https://github.com/realh/${pname}";
    rev = "${version}455c12c68f6d48bcbe39852accaa6625e";
    hash = "sha256-NugIXThK9ZB+Qp92kJuUw4ShYLZjkAZZo3n+wWT/B8E=";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/
    cp -r multi-monitors-add-on@spin83 $_
  '';
}
