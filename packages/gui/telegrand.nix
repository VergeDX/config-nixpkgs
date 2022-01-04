{ rustPlatform, fetchgit, pkg-config, wrapGAppsHook, glib, cairo, graphene, gnome2, gdk-pixbuf, gtk4, libadwaita, ... }:
rustPlatform.buildRustPackage rec {
  pname = "telegrand";
  version = "4580816";

  src = fetchgit {
    url = "https://github.com/melix99/${pname}";
    rev = "${version}7934fb0e7f85cd7cdb0d89e068fb31484";
    hash = "sha256-3BywWm7pZ7nBG/IXFRTjpX2n/iNvFcQo85CBJ/DGaXs=";
  };

  # cargoSha256 = "";
  cargoHash = "sha256-DPSA7K7eYvLbfWqgyTgeKhWrt83XpoAONfkZg4ITO3g=";

  nativeBuildInputs = [ pkg-config wrapGAppsHook ];
  buildInputs = [ glib cairo graphene gnome2.pango gdk-pixbuf ]
    ++ [ gtk4 libadwaita ];
}
