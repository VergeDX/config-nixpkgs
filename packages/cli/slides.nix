{ buildGoModule, fetchgit }:
buildGoModule rec {
  name = "slides";
  version = "v0.2.0";
  vendorSha256 = "sha256-zqjHz63U+Oelu9XSnc9e/XR3J7kPzHBKlFWAw3P6zng=";

  src = fetchgit {
    url = "https://github.com/maaslalani/${name}";
    rev = version;
    sha256 = "sha256-HScZtRtYsA6A5tW2nX+GbtSKH3xXQSPuz7s+vb2Ol28=";
  };

  checkPhase = "echo";
}
