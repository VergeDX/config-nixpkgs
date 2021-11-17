{ pkgs, ... }:
{
  SF-Pro = (pkgs.callPackage ./common.nix {
    name = "SF-Pro";
    fontName = "SF Pro Fonts";
    sha256 = "sha256-+JF3SyNi+6rEVIEg/Llqu0w/z8gqBbbLtP3cCl9Kqjo=";
  });
  SF-Compact = (pkgs.callPackage ./common.nix {
    name = "SF-Compact";
    fontName = "SF Compact Fonts";
    sha256 = "sha256-SHZHMCpqlrLH/3cEbIcnZg4lDQYl765bVO3v1o1D6hg=";
  });
  SF-Mono = (pkgs.callPackage ./common.nix {
    name = "SF-Mono";
    fontName = "SF Mono Fonts";
    sha256 = "sha256-8niJPk3hGfK1USIs9eoxZ6GlM4aZ7ZObmQj2Zomj+Go=";
  });
  SF-Arabic = (pkgs.callPackage ./common.nix {
    name = "SF-Arabic";
    fontName = "SF Arabic Fonts";
    sha256 = "sha256-vlg0ZBEan5BQfJpSXHDqPTpvVKP/Y1MCnDDM2L3ioyo=";
  });
  NY = (pkgs.callPackage ./common.nix {
    name = "NY";
    fontName = "NY Fonts";
    sha256 = "sha256-MAxQkdR40YUDl7z0OYbuwiueOoB2JuYikIu11CqiAto=";
  });
}
