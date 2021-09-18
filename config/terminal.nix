{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.xfce.terminal
    pkgs.alacritty

    pkgs.screenfetch
    pkgs.neofetch
    pkgs.lolcat

    pkgs.libnotify
  ];

  # https://github.com/alacritty/alacritty/wiki/Color-schemes
  home.file.".config/alacritty/alacritty.yml".text = ''
    # Colors (Terminal.app Basic)
    colors:
      primary:
        background: '#FFFFFF'
        foreground: '#000000'
      normal:
        black:      '#000000'
        red:        '#990000'
        green:      '#00A600'
        yellow:     '#999900'
        blue:       '#0000B2'
        magenta:    '#B200B2'
        cyan:       '#00A6B2'
        white:      '#BFBFBF'
      bright:
        black:      '#666666'
        red:        '#E50000'
        green:      '#00D900'
        yellow:     '#E5E500'
        blue:       '#0000FF'
        magenta:    '#E500E5'
        cyan:       '#00E5E5'
        white:      '#E5E5E5'

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

  # https://sw.kovidgoyal.net/kitty/
  programs.kitty.enable = true;
  programs.kitty.font = { package = pkgs.hack-font; name = "Hack"; };
  # https://github.com/dexpota/kitty-themes
  # https://sw.kovidgoyal.net/kitty/conf/
  programs.kitty.extraConfig = "include ${pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/rose-pine/kitty/main/rose-pine-dawn.conf";
    sha256 = "sha256-Y7lb3VKXDqbMhnzu1BRsm5RAY6MwM11i38EiTtdRH/s=";
  }}";
}
