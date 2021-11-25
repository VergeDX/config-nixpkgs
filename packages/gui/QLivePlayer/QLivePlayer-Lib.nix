{ rustPlatform, fetchgit, perl, ... }:
rustPlatform.buildRustPackage rec {
  pname = "QLivePlayer-Lib";
  version = "c91879a";

  src = fetchgit {
    url = "https://github.com/THMonster/${pname}";
    rev = "${version}4aca19d957d79dbdecab68b88f022f905";
    hash = "sha256-Tr0NUKRPFKrc21p6mcZvbU79ERFey+m66/ysgkkhtEA=";
  };

  cargoPatches = [ ./Cargo-lock-update.patch ];
  cargoSha256 = "sha256-IJAtLIWqjgU1Pg/HSd7W8eUGK3JKELuD++W/zuYaoGw=";
  nativeBuildInputs = [ perl ];
  doCheck = false;
}
