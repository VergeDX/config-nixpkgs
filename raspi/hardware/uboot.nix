{ pkgs ? import <nixpkgs> { } }:
# https://github.com/NixOS/nixpkgs/pull/139865
pkgs.pkgsCross.aarch64-multiplatform.ubootRaspberryPi4_64bit.overrideAttrs (old: {
  patches = old.patches ++ [
    (pkgs.fetchpatch {
      url = "https://patchwork.ozlabs.org/series/259129/mbox/";
      sha256 = "04x55a62a5p4mv0ddpx7dnsh5pnx46vibnq8cry7hgwf4krl64gl";
    })
  ];
})
