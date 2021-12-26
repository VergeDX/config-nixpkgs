{ buildPythonPackage, fetchgit, ... }:
buildPythonPackage rec {
  pname = "wakatime";
  version = "13.1.0";

  src = fetchgit {
    url = "https://github.com/${pname}/legacy-python-cli";
    rev = "${version}";
    hash = "sha256-MS7hMoaGj8uG16PM6a9hlnZUzyB3NTeNF6T5vT/Q/zo=";
  };

  # setuptoolsCheckPhase = "echo -n";
  doCheck = false;
}
