{ unzip, fetchurl, ... }:
# https://gitlab.gnome.org/GNOME/file-roller/-/issues/137
(unzip.overrideAttrs (old: rec {
  # https://src.fedoraproject.org/rpms/unzip/tree/rawhide
  baseUrl = "https://src.fedoraproject.org/rpms/unzip/raw/rawhide/f";
  # https://github.com/archlinux/svntogit-packages/blob/packages/unzip/trunk/PKGBUILD
  patches = old.patches ++ [
    (fetchurl {
      url = "${baseUrl}/unzip-6.0-alt-iconv-utf8.patch";
      hash = "sha256-5kyd2zjC59CL24DFl/Mu6WDhj76MuYLkRLHs4DrJXOw=";
    })
    (fetchurl {
      url = "${baseUrl}/unzip-6.0-alt-iconv-utf8-print.patch";
      hash = "sha256-uZDY2NjgJ3eZlIShMhcGZupzaoZfmtgdplHcY3JUdf8=";
    })
  ];
}))
