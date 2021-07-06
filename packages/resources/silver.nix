{ pkgs, ... }:
pkgs.rustPlatform.buildRustPackage rec {
  name = "silver";
  version = "v2.0.0";

  src = pkgs.fetchgit {
    url = "https://github.com/reujab/${name}";
    rev = version;
    sha256 = "sha256-CFQMIyG4+cMp2Do4ygbbl62GMw9gvpV22TcxtgQ9LN0=";
  };

  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = [ pkgs.openssl ];
  cargoSha256 = "sha256-AawTTfjFfz6xgJYKNdBNl7sTnhuR5UziTnPH1DLOF+k=";
}
