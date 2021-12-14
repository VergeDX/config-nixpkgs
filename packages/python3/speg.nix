{ buildPythonPackage, fetchPypi, ... }:
buildPythonPackage rec {
  pname = "speg";
  version = "0.3";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-EMvvR+Fo38YvFNtXXPHEKAN6K4gc7mw8/O2gQ5wkPnE=";
    extension = "zip";
  };

  doCheck = false;
}
