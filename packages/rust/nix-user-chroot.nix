{ rustPlatform, fetchgit, ... }:
rustPlatform.buildRustPackage rec {
  pname = "nix-user-chroot";
  version = "1.2.2";

  src = fetchgit {
    url = "https://github.com/nix-community/${pname}";
    rev = "${version}";
    hash = "sha256-8w2/Ncfcg6mMRFgMZg3CBBtAO/FI6G6hDMyaLCS3hwk=";
  };

  # cargoSha256 = "";
  cargoHash = "sha256-TWmLB+44mmMA/g/JjprJaOZyApRgrxyv6ytPLmbrSqc=";

  # Network connection needed in checkPhase.
  doCheck = false;
}
