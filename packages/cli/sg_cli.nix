{ rustPlatform, fetchgit, ... }:
rustPlatform.buildRustPackage rec {
  pname = "sg_cli";
  version = "9686b0e";

  src = fetchgit {
    url = "https://github.com/Vanilla-s-Lab/${pname}";
    rev = "${version}8400446ed934076f9fdd9a67ac07846cb";
    hash = "sha256-APShOBzrOKUNEg7pQ7IKZDqX3eETuEWetFG7cAChmkA=";
  };

  # cargoSha256 = "";
  cargoHash = "sha256-liK4JyoDIU04U2Swl9EJbpepfY116ETcSzI/vEBJ8eU=";
}
