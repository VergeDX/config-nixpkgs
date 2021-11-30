{ rustPlatform, fetchgit, pkg-config, luajit, ... }:
rustPlatform.buildRustPackage rec {
  pname = "freshfetch";
  version = "0.1.2";

  src = fetchgit {
    url = "https://github.com/k4rakara/${pname}";
    rev = "v${version}";
    hash = "sha256-8aXHffv4hHheQZGbYLsIMBxrEHW1uxonnJiSfmrgFd8=";
  };

  cargoSha256 = "sha256-oPnbyl+BmXqFSraov8RVn55UH2kshDD24w/tLiR/AFw=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ luajit ];
}
