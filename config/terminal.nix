{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.xfce.terminal
    pkgs.alacritty

    pkgs.screenfetch
    pkgs.neofetch
    pkgs.lolcat

    # https://github.com/rofl0r/proxychains-ng
    (pkgs.proxychains.overrideAttrs (old: {
      configureScript = "./configure --sysconfdir=.config";
      postInstall = old.postInstall + ''
        # https://stackoverflow.com/questions/4881930/remove-the-last-line-from-a-file-in-bash
        # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/tools/networking/proxychains/default.nix#L23
        sed -i '$ d' $out/etc/proxychains.conf
        sed -i '$ d' $out/etc/proxychains.conf
        printf "socks5 127.0.0.1 1089\n\n" >> $out/etc/proxychains.conf
      '';
    }))

    pkgs.guake
    (pkgs.makeAutostartItem { name = "guake"; package = pkgs.guake; })
  ];

  # https://github.com/alacritty/alacritty/wiki/Color-schemes
  home.file.".config/alacritty/alacritty.yml".text = ''
    # https://github.com/alacritty/alacritty/wiki/Color-schemes
    # Colors (iTerm 2 default theme)
    colors:
      # Default colors
      primary:
        background: '#101421'
        foreground: '#fffbf6'

     # Normal colors
      normal:
        black:   '#2e2e2e'
        red:     '#eb4129'
        green:   '#abe047'
        yellow:  '#f6c744'
        blue:    '#47a0f3'
        magenta: '#7b5cb0'
        cyan:    '#64dbed'
        white:   '#e5e9f0'

     # Bright colors
      bright:
        black:   '#565656'
        red:     '#ec5357'
        green:   '#c0e17d'
        yellow:  '#f9da6a'
        blue:    '#49a4f8'
        magenta: '#a47de9'
        cyan:    '#99faf2'
        white:   '#ffffff'

    # https://wiki.gentoo.org/wiki/Alacritty#Font_configuration
    # Font configuration (changes require restart)
    font:
      # The normal (roman) font face to use.
      normal:
        family: Hack
        # Style can be specified to pick a specific face.
        style: Regular

      # The bold font face
      bold:
        family: Hack
        # Style can be specified to pick a specific face.
        # style: Bold

      # The italic font face
      italic:
        family: Hack
        # Style can be specified to pick a specific face.
        # style: Italic
      size: 11.0
  '';
}
