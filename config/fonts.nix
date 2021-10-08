{ fonts, home, pkgs, ... }:
with pkgs; {
  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;
  home.packages = [ source-han-sans source-han-mono source-han-serif source-han-code-jp ]
    ++ [ noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji noto-fonts-emoji-blob-bin ]
    ++ [ roboto roboto-slab roboto-mono ]
    ++ [ dejavu_fonts vdrsymbols hack-font vistafonts nerdfonts ];

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
