{ fonts, home, pkgs, ... }:
with pkgs; {
  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;
  home.packages = [ source-han-sans source-han-mono source-han-serif source-han-code-jp ]
    ++ [ noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji noto-fonts-emoji-blob-bin ]
    ++ [ roboto roboto-slab roboto-mono ]
    ++ [ dejavu_fonts vdrsymbols hack-font vistafonts nerdfonts ]
    ++ (with pkgs; [
    # https://developer.apple.com/fonts/
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Pro";
      fontName = "San Francisco Pro";
      sha256 = "sha256-Q2QgwnxNFf+zzLbZ/gF2uvE3TZpapmQTUY4enMmMCOM=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Compact";
      fontName = "San Francisco Compact";
      sha256 = "sha256-1wEChhE6B3Cj6HvmvOfFP26/BHvKbwdVAVT9b8he0sI=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Mono";
      fontName = "SF Mono Fonts";
      sha256 = "sha256-dsQV6a7gUkCHzGoEIRPbazjxoZ8uKG+AeqKXVkYTcKk=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "SF-Arabic";
      fontName = "SF Arabic Fonts";
      sha256 = "sha256-DI76Da0L+J56z7OHGTudo76PWEFUYuE1i5lxK/xiB6o=";
    })
    (callPackage ../packages/fonts/common.nix {
      name = "NY";
      fontName = "NY Fonts";
      sha256 = "sha256-qW/yCo4UPxz/MT7AXtK40pCjuf9gEKsGIZMldMn3lAI=";
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
