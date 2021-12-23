{ stdenv, fetchgit, glib, zip, unzip, ... }:
stdenv.mkDerivation rec {
  pname = "Fly-Pie";
  version = "12";

  extensionName = "flypie@schneegans.github.com";

  src = fetchgit {
    url = "https://github.com/Schneegans/${pname}";
    rev = "v${version}";
    hash = "sha256-z56emJCnf9hXtY9C5czXRRXzzBgoK7683sH+D70v7J4=";
  };

  nativeBuildInputs = [ glib zip ];
  # https://github.com/Schneegans/Fly-Pie/blob/v12/Makefile#L16
  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${extensionName}
    ${unzip}/bin/unzip ${extensionName}.zip -d $_
  '';
}
