{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.xfce.terminal
    pkgs.alacritty

    pkgs.screenfetch
    pkgs.neofetch
    pkgs.lolcat

    pkgs.guake
    pkgs.terminator
    pkgs.termite
    pkgs.rxvt-unicode

    pkgs.libnotify
  ];

  # https://github.com/alacritty/alacritty/wiki/Color-schemes
  home.file.".config/alacritty/alacritty.yml".text = ''
    # https://github.com/alacritty/alacritty/wiki/Color-schemes
    # Colors (Solarized Light)
    colors:
      # Default colors
      primary:
        background: '#fdf6e3' # base3
        foreground: '#657b83' # base00

      # Cursor colors
      cursor:
        text:   '#fdf6e3' # base3
        cursor: '#657b83' # base00

      # Normal colors
      normal:
        black:   '#073642' # base02
        red:     '#dc322f' # red
        green:   '#859900' # green
        yellow:  '#b58900' # yellow
        blue:    '#268bd2' # blue
        magenta: '#d33682' # magenta
        cyan:    '#2aa198' # cyan
        white:   '#eee8d5' # base2

      # Bright colors
      bright:
        black:   '#002b36' # base03
        red:     '#cb4b16' # orange
        green:   '#586e75' # base01
        yellow:  '#657b83' # base00
        blue:    '#839496' # base0
        magenta: '#6c71c4' # violet
        cyan:    '#93a1a1' # base1
        white:   '#fdf6e3' # base3

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
  # https://askubuntu.com/questions/703611/how-to-call-desktop-notifications-on-ubuntu-gnome
  programs.kitty.extraConfig = ''
    include ./theme.conf
    command_on_bell "notify-send foo bar"
  '';
  home.file.".config/kitty/theme.conf".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Solarized_Light.conf";
    sha256 = "sha256-1UN/jP63IqA0L3848pAjoeeG/uyoVD91zBexXzD3tvU=";
  };
}
