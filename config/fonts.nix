{ fonts, home, pkgs, ... }:
with pkgs; {
  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;
  home.packages = [ source-han-sans source-han-mono source-han-serif source-han-code-jp ]
    ++ [ noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji noto-fonts-emoji-blob-bin ]
    ++ [ roboto roboto-slab roboto-mono ]
    ++ [ dejavu_fonts vdrsymbols hack-font nerdfonts ]
    ++ [ vistafonts vistafonts-chs ]
    ++ (with pkgs; [
    # https://developer.apple.com/fonts/
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Pro";
      fontName = "SF Pro Fonts";
      sha256 = "sha256-+JF3SyNi+6rEVIEg/Llqu0w/z8gqBbbLtP3cCl9Kqjo=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Compact";
      fontName = "SF Compact Fonts";
      sha256 = "sha256-SHZHMCpqlrLH/3cEbIcnZg4lDQYl765bVO3v1o1D6hg=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Mono";
      fontName = "SF Mono Fonts";
      sha256 = "sha256-8niJPk3hGfK1USIs9eoxZ6GlM4aZ7ZObmQj2Zomj+Go=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Arabic";
      fontName = "SF Arabic Fonts";
      sha256 = "sha256-vlg0ZBEan5BQfJpSXHDqPTpvVKP/Y1MCnDDM2L3ioyo=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "NY";
      fontName = "NY Fonts";
      sha256 = "sha256-MAxQkdR40YUDl7z0OYbuwiueOoB2JuYikIu11CqiAto=";
    })
  ]);

  # https://wiki.archlinux.org/title/Localization_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Simplified_Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  # https://github.com/yrashk/nix-home/blob/master/home.nix#L285
  home.file.".fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Source Han Sans SC</family>
          <family>Source Han Sans TC</family>
          <family>Source Han Sans HW</family>
          <family>Source Han Sans K</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>Source Han Sans SC</family>
          <family>Source Han Sans TC</family>
          <family>Source Han Sans HW</family>
          <family>Source Han Sans K</family>
        </prefer>
      </alias>
    </fontconfig>
  '';
}
