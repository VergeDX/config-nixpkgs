{ buildPythonPackage, fetchPypi, libmysqlclient, lib }:
buildPythonPackage rec {
  pname = "mariadb";
  version = "1.0.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-S3sbMHowo8sSJy2bHcoNE7Zr09QVtKzrCkB/CYPzQaM=";
    extension = "zip";
  };

  nativeBuildInputs = [
    libmysqlclient
  ];

  meta = with lib; {
    description = "MariaDB Connector/Python";
    homepage = "https://github.com/mariadb-corporation/mariadb-connector-python";
    license = licenses.lgpl21;
    maintainers = with maintainers; [ vanilla ];
  };
}
