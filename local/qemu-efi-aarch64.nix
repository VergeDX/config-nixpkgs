{ pkgs, ... }:
pkgs.stdenv.mkDerivation rec {
  name = "qemu-efi-aarch64";
  version = "2020.11-4";

  src = pkgs.fetchurl {
    url = "http://mirrors.kernel.org/ubuntu/pool/main/e/edk2/${name}_${version}_all.deb";
    sha256 = "sha256-OAzPVnl82p9Jt2yxx1mwiCL8Gjb3LcpiKNjxWtIr/mM=";
  };

  buildInputs = [ pkgs.dpkg ];
  unpackPhase = "dpkg-deb -x ${src} .";
  installPhase = "mkdir -p $out && cp -r * $out";
}
