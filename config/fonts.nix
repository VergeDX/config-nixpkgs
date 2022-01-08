{ fonts, home, pkgs, ... }:
let apple-fonts = import ../packages/fonts/apple.nix { inherit pkgs; }; in
let Win10_LTSC_2021_fonts = pkgs.callPackage ../packages/fonts/Win10_LTSC_2021_fonts.nix { }; in
with pkgs; {
  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;
  home.packages = [ source-han-sans source-han-mono source-han-serif source-han-code-jp ]
    ++ [ noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji noto-fonts-emoji-blob-bin ]
    ++ [ roboto roboto-slab roboto-mono ]
    ++ [ dejavu_fonts vdrsymbols hack-font nerdfonts ]
    # https://developer.apple.com/fonts/
    ++ (with apple-fonts; [ SF-Pro SF-Compact SF-Mono SF-Arabic NY ])
    ++ [ Win10_LTSC_2021_fonts dosemu_fonts ];

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
