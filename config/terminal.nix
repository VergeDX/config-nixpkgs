{ home, pkgs, ... }:
# let tide = pkgs.callPackage ../packages/resources/tide.nix { }; in
# let ayamir-dotfiles = pkgs.callPackage ../packages/resources/ayamir-dotfiles.nix { }; in
{
  home.packages = [
    # pkgs.xfce.terminal
    pkgs.alacritty
    pkgs.cool-retro-term

    pkgs.screenfetch
    pkgs.neofetch
    pkgs.disfetch
    pkgs.lolcat

    pkgs.libnotify
    pkgs.nur.repos.vanilla.fastfetch
    pkgs.nur.repos.vanilla.freshfetch
  ];

  # home.file.".config/neofetch".source =
  #   "${ayamir-dotfiles}/gruvbox/.config/neofetch";

  # https://github.com/alacritty/alacritty/wiki/Color-schemes
  home.file.".config/alacritty/alacritty.yml".text =
    let rose-pine-dawn.yml = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/alacritty/main/rose-pine-dawn.yml";
      sha256 = "sha256-/1y/sYIugR27QgbM2rG4WganTPbdqbAgnbrjkDXIgUg=";
    }; in
    ''
      # https://github.com/rose-pine/alacritty#usage
      import:
        - ${rose-pine-dawn.yml}

      # https://github.com/alacritty/alacritty/issues/2431
      # 8 : 3 = 102 : 38.25 = 104 : 39 = 112 : 42
      window:
        dimensions:
          columns: 112
          lines: 42

      # https://wiki.gentoo.org/wiki/Alacritty#Font_configuration
      # Font configuration (changes require restart)
      font:
        # The normal (roman) font face to use.
        normal:
          family: Hack Nerd Font
          # Style can be specified to pick a specific face.
          style: Regular

        # The bold font face
        bold:
          family: Hack Nerd Font
          # Style can be specified to pick a specific face.
          style: Bold

        # The italic font face
        italic:
          family: Hack Nerd Font
          # Style can be specified to pick a specific face.
          style: Italic
        size: 11.0
    '';

  # https://sw.kovidgoyal.net/kitty/
  programs.kitty.enable = true;
  programs.kitty.font = { package = pkgs.hack-font; name = "Hack Nerd Font"; };
  # https://github.com/dexpota/kitty-themes
  # https://sw.kovidgoyal.net/kitty/conf/
  programs.kitty.extraConfig = "include ${pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/rose-pine/kitty/main/rose-pine-dawn.conf";
    sha256 = "sha256-Y7lb3VKXDqbMhnzu1BRsm5RAY6MwM11i38EiTtdRH/s=";
  }}";

  # https://github.com/kovidgoyal/kitty/issues/1613#issuecomment-492036864
  home.sessionVariables = { TERM = "xterm"; };

  # https://github.com/reujab/silver/tree/v2.0.0#configuration
  home.file.".config/silver/silver.toml".text = ''
    [[left]]
    name = "dir"
    color.background = "blue"
    color.foreground = "black"

    [[left]]
    name = "git"
    color.background = "green"
    color.foreground = "black"

    [[right]]
    name = "status"
    color.background = "white"
    color.foreground = "black"

    [[right]]
    name = "cmdtime"
    color.background = "magenta"
    color.foreground = "black"

    [[right]]
    name = "shell"
    color.background = "green"
    color.foreground = "black"
  '';

  # https://github.com/IlanCosman/tide/tree/v5.0.1#installation
  # home.file.".config/fish/completions/tide.fish".source = "${tide}/completions/tide.fish";
  # home.file.".config/fish/conf.d/_tide_init.fish".source = "${tide}/conf.d/_tide_init.fish";
  # home.file.".config/fish/functions".source = "${tide}/functions";
}
