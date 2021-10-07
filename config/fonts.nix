{ fonts, home, pkgs, ... }:
let
  sf-pro = (pkgs.callPackage ../packages/fonts/sf-pro.nix { });
  sf-compact = (pkgs.callPackage ../packages/fonts/sf-compact.nix { });
  sf-mono = (pkgs.callPackage ../packages/fonts/sf-mono.nix { });
  sf-arabic-beta = (pkgs.callPackage ../packages/fonts/sf-arabic-beta.nix { });
  new-york = (pkgs.callPackage ../packages/fonts/new-york.nix { });
in
{
  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;
  home.packages = (with pkgs; # 思源黑体 (Source Han Sans)
    [ source-han-sans source-han-mono source-han-serif source-han-code-jp ])
  ++ [ sf-pro sf-compact sf-mono sf-arabic-beta new-york ]
  ++ (with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji ])
  ++ (with pkgs; [ roboto roboto-slab roboto-mono ]) # Roboto
  ++ [ pkgs.hack-font pkgs.nerdfonts ];

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
