{ fonts, home, pkgs, ... }:
{
  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.source-han-sans-simplified-chinese
    pkgs.source-han-serif-simplified-chinese

    (pkgs.callPackage ../packages/fonts/sf-pro.nix { })
    (pkgs.callPackage ../packages/fonts/sf-compact.nix { })
    (pkgs.callPackage ../packages/fonts/sf-mono.nix { })
    (pkgs.callPackage ../packages/fonts/sf-arabic-beta.nix { })
    (pkgs.callPackage ../packages/fonts/new-york.nix { })

    pkgs.roboto
    pkgs.roboto-slab
    pkgs.roboto-mono

    # https://wiki.archlinux.org/title/Font_Configuration_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
    pkgs.dejavu_fonts
    pkgs.vistafonts
  ];

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
