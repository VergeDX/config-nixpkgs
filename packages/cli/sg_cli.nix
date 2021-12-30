{ rustPlatform, fetchgit, ... }:
rustPlatform.buildRustPackage rec {
  pname = "sg_cli";
  version = "735c1e5";

  src = fetchgit {
    url = "https://github.com/Vanilla-s-Lab/${pname}";
    rev = "${version}96c0ea667d4a69d53f3d90c0aa66dda7d";
    hash = "sha256-YwA9oh9RTsgbMZjpP2q/l9lutgyRhL6QJ6Ie5gc1GV0=";
  };

  cargoHash = "sha256-4QR1dxQ9AU7A+yxvego7uydAEJHnwIYMeheYMf18aSM=";
}
