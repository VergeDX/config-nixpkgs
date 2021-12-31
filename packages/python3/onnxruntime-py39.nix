{ python3Packages, fetchPypi, ... }:
python3Packages.buildPythonPackage rec {
  pname = "onnxruntime";
  version = "1.10.0";
  format = "wheel";

  # https://discourse.nixos.org/t/packaging-a-python-wheel-only-library/14598
  src = fetchPypi {
    inherit pname version format;
    hash = "sha256-NM+weor5Gzt/gq2duPbc5n8L1nLNr2WdD9hqq6egIdk=";

    dist = "cp39";

    python = "cp39";
    abi = "cp39";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
  };

  # https://nixos.wiki/wiki/Packaging/Python
  propagatedBuildInputs = with python3Packages;
    [ protobuf flatbuffers numpy ];
}
