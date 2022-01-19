{ buildGoModule, fetchgit, ... }:
buildGoModule rec {
  pname = "catfetch";
  version = "e9a2374";

  src = fetchgit {
    url = "https://github.com/Domterion/${pname}";
    rev = "${version}406b026e8b5b98905d0dadb9788b3309e";
    hash = "sha256-QUWpwBjTwqBGwMEUe8zj30VxZcYuxfVSlbTZ6KWIbDA=";
  };

  vendorSha256 = "sha256-mUm4ZtHNxeRCuVLTqgZM+je1k5FJ/kMWgoIDzYiAjbI=";
}
