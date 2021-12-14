{ buildPythonPackage, fetchPypi, callPackage, ... }:
let speg = callPackage ./speg.nix { }; in
buildPythonPackage rec {
  pname = "cson";
  version = "0.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-7owBZvzR9ReJiHGX4+g1Sse++jlvwpcGvOta8l7cngE=";
  };

  propagatedBuildInputs = [ speg ];
}
