{ config, pkgs, ... }:

let
  tabnine-vim = (pkgs.callPackage ./packages/resources/tabnine-vim.nix) { };
  peda = (pkgs.callPackage ./packages/resources/peda.nix) { };
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vanilla";
  home.homeDirectory = "/home/vanilla";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  programs.zsh.enable = true;
  # https://github.com/nix-community/home-manager/issues/1338
  programs.zsh.initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  # https://github.com/nix-community/home-manager/blob/master/modules/home-environment.nix#L230
  home.sessionVariables = {
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
  };

  # https://github.com/NickCao/flakes/blob/master/nixos/local/configuration.nix#L246
  programs.chromium.enable = true; # AdGuard
  programs.chromium.extensions = [ "bgnkhhnnamicmpeenaelnjfhikgbkllg" ];
  programs.neovim =
    let doki-theme-vim = (pkgs.callPackage ./packages/themes/doki-theme-vim.nix) { };
    in
    {
      enable = true;
      # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/programs/neovim.nix#L66
      plugins = [
        doki-theme-vim
        pkgs.vimPlugins.vim-airline
        pkgs.vimPlugins.vim-airline-themes
        pkgs.vimPlugins.vim-polyglot
        pkgs.vimPlugins.vim-lastplace
      ];

      # https://github.com/doki-theme/doki-theme-vim#installation
      # https://github.com/doki-theme/doki-theme-vim/tree/master/colors
      # https://medium.com/@hql287/10-vim-tips-to-ease-the-learning-curve-c8234cbdafa5
      # https://vimjc.com/vim-powerline.html
      extraConfig = ''
        packadd! ${doki-theme-vim.pkadd-name}
        syntax enable
        colorscheme emilia_dark
        set number
        set showtabline=2
        set rtp+=${tabnine-vim.out}/${tabnine-vim.name}
      '';
    };

  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.source-han-sans-simplified-chinese
    pkgs.source-han-serif-simplified-chinese
    (pkgs.callPackage ./packages/fonts/sf-pro.nix { })
    (pkgs.callPackage ./packages/fonts/sf-compact.nix { })
    (pkgs.callPackage ./packages/fonts/sf-mono.nix { })
    (pkgs.callPackage ./packages/fonts/sf-arabic-beta.nix { })
    (pkgs.callPackage ./packages/fonts/new-york.nix { })
    pkgs.roboto
    pkgs.roboto-slab
    pkgs.roboto-mono
    # https://wiki.archlinux.org/title/Font_Configuration_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
    pkgs.dejavu_fonts
    pkgs.vistafonts

    # /nix/store/jz2fqzfq4z664q5dcpmxk5kd7l0phgrd-v2ray-assets
    (pkgs.callPackage ./packages/gui/qv2ray-pre.nix { })
    (pkgs.makeAutostartItem { name = "qv2ray"; package = (pkgs.callPackage ./packages/gui/qv2ray-pre.nix) { }; })
    pkgs.v2ray

    pkgs.xfce.terminal
    pkgs.powerline
    pkgs.powerline-go
    pkgs.powerline-fonts
    pkgs.powerline-symbols
    pkgs.powerline-rs
    pkgs.starship
    pkgs.alacritty
    pkgs.screenfetch
    pkgs.neofetch
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

    pkgs.zsh-powerlevel10k
    pkgs.meslo-lgs-nf
    pkgs.guake
    (pkgs.makeAutostartItem { name = "guake"; package = pkgs.guake; })

    pkgs.gnome.gnome-tweak-tool
    (pkgs.callPackage ./packages/themes/layan-gtk-theme.nix { })
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    (pkgs.callPackage ./packages/themes/flat-remix-gnome.nix { })
    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.jiggle
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.blur-me
    pkgs.gnomeExtensions.openweather
    pkgs.gnomeExtensions.tray-icons
    pkgs.gnomeExtensions.simple-net-speed
    pkgs.gnomeExtensions.proxy-switcher
    pkgs.gnomeExtensions.extension-list
    pkgs.gnomeExtensions.eclipse
    pkgs.gnomeExtensions.screenshot-tool
    # Credit: @Cyunrei
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.extensions-in-system-menu
    (pkgs.callPackage ./packages/gnome/dash-to-dock-gnome40.nix { })
    # https://www.linuxlinks.com/excellent-gnome-desktop-extensions/
    pkgs.gnomeExtensions.arcmenu
    pkgs.gnomeExtensions.gsconnect
    # https://extensions.gnome.org/
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.status-area-horizontal-spacing
    pkgs.gnomeExtensions.window-is-ready-notification-remover
    (pkgs.callPackage ./packages/gnome/lockkeys.nix { })
    pkgs.gnomeExtensions.disconnect-wifi
    pkgs.conky

    pkgs.arion
    pkgs.apfs-fuse
    # https://github.com/HeQuanX/navicat-keygen-tools/blob/main/README.zh-CN.md
    pkgs.appimagekit
    (pkgs.callPackage ./packages/cli/navicat-keygen-tools.nix { })
    pkgs.appimage-run
    pkgs.texlive.combined.scheme-full

    pkgs.unzip
    pkgs.scrcpy
    pkgs.glxinfo
    pkgs.mr
    pkgs.tree
    pkgs.translate-shell
    pkgs.wget
    pkgs.htop
    (pkgs.callPackage ./packages/fcitx/ssf2fcitx.nix { })
    (pkgs.callPackage ./packages/cli/checkra1n.nix { })
    pkgs.p7zip
    (pkgs.callPackage ./packages/cli/slides.nix { })
    pkgs.file
    pkgs.ncdu
    pkgs.lsd
    pkgs.screen
    pkgs.tmux
    pkgs.idevicerestore
    pkgs.usbutils
    (pkgs.callPackage ./packages/cli/xsp.nix { })
    pkgs.hub

    pkgs.nmap
    pkgs.metasploit
    (pkgs.callPackage ./packages/gui/armitage.nix { })
    pkgs.binwalk
    pkgs.gnome.ghex
    pkgs.binutils
    pkgs.exiftool
    pkgs.zsteg
    (pkgs.callPackage ./packages/gui/stegsolve.nix { })
    (pkgs.callPackage ./packages/gui/idafree.nix { })
    pkgs.gdb
    pkgs.pwntools
    pkgs.ltrace
    pkgs.bind
    pkgs.postman
    pkgs.sqlmap

    # https://nixos.wiki/wiki/Wine
    pkgs.wineWowPackages.stable
    pkgs.wineWowPackages.fonts
    (pkgs.winetricks.override { wine = pkgs.wineWowPackages.stable; })

    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.nodePackages.npm-check-updates
    # https://nixos.wiki/wiki/Node.js
    pkgs.yarn
    pkgs.yarn2nix
    (pkgs.callPackage ./packages/cli/pxder/pxder.nix { })

    # https://github.com/bkchr/nixos-config/blob/master/system-with-gui-configuration.nix#L8
    pkgs.tdesktop
    (pkgs.makeAutostartItem { name = "telegramdesktop"; package = pkgs.tdesktop; })

    # https://nixos.wiki/wiki/Nvidia
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec -a "$0" "$@"
    '')

    pkgs.gimp-with-plugins
    pkgs.remmina
    (pkgs.callPackage ./packages/gui/motrix.nix { })
    pkgs.zoom-us
    pkgs.google-play-music-desktop-player
    pkgs.tor-browser-bundle-bin
    pkgs.qbittorrent
    pkgs.obs-studio
    pkgs.gnome3.baobab
    pkgs.virt-manager
    pkgs.virt-manager-qt
    pkgs.albert
    (pkgs.makeAutostartItem { name = "albert"; package = pkgs.albert; })
    (pkgs.callPackage ./packages/gui/edex-ui.nix { })

    pkgs.android-studio
    pkgs.androidStudioPackages.canary
    # pkgs.android-tools
    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui
    (pkgs.flutter.override (prev: {
      buildFHSUserEnv = { targetPkgs, ... }@args:
        prev.buildFHSUserEnv (args // {
          targetPkgs = p: with p;
            (targetPkgs p) ++ [ gtk3.dev glib.dev ];
        });
    }))
    pkgs.clang
    pkgs.cmake
    pkgs.ninja
    pkgs.pkg-config

    # nixpkgs.config.allowUnfree = true;
    pkgs.firefox
    pkgs.google-chrome
    (pkgs.steam.override {
      withPrimus = true;
      # https://github.com/NixOS/nixpkgs/pull/126142
      # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/games/steam/fhsenv.nix#L241
      extraLibraries = pkgs: [ pkgs.pipewire.lib ];
    })
    pkgs.vscode
    (pkgs.wpsoffice.overrideAttrs (old: {
      version = "11.1.0.10161";
      src = pkgs.fetchurl {
        url = "https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/10161/wps-office_11.1.0.10161.XA_amd64.deb";
        sha256 = "sha256-jKYIRChpPIGDP2/fE0QqnqkFJjjVvcDk11EgdfQAB8M";
      };
      postFixup = old.postFixup + ''
        cd $out/share/applications/
        sed -i 's/Exec=/Exec=steam-run /g' *.desktop
      '';
    }))
    pkgs.steam-run
    pkgs.osu-lazer
    (pkgs.callPackage ./packages/gui/olympus.nix { })
    pkgs.minecraft
    pkgs.multimc
    pkgs.stellarium
    (pkgs.callPackage ./packages/gui/google-earth-pro.nix { })

    pkgs.jetbrains.rider
    pkgs.dotnet-sdk
    pkgs.mono
    pkgs.jetbrains.idea-ultimate
    pkgs.jdk11
    pkgs.kotlin
    pkgs.jetbrains.goland
    pkgs.go
    pkgs.jetbrains.pycharm-professional
    pkgs.python3Full
    pkgs.jetbrains.clion
    pkgs.cmake
    pkgs.gnumake

    pkgs.maven
    pkgs.gradle
  ];

  nixpkgs.config.allowUnfree = true;
  home.file.".config/flutter/settings".text = ''{ "enable-linux-desktop": true }'';
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

  # https://github.com/alacritty/alacritty/wiki/Color-schemes
  home.file.".config/alacritty/alacritty.yml".text = ''
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
  '';

  # https://github.com/longld/peda#installation
  home.file.".gdbinit".text = "source ${peda.out}/${peda.name}/peda.py";
  # https://wiki.archlinux.org/title/GTK_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  home.file.".config/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name = Tela-pink
    gtk-theme-name = Layan-light-solid
  '';

  imports = [
    ./config/fcitx5_config.nix
    ./config/git_config.nix
    ./config/fish_config.nix
  ];
}
