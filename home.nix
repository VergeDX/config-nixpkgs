{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "20.09";

  home.username = "vanilla";
  home.homeDirectory = "/home/vanilla";

  home.packages = [
    pkgs.nixpkgs-fmt

    # /nix/store/jz2fqzfq4z664q5dcpmxk5kd7l0phgrd-v2ray-assets
    (pkgs.callPackage ./packages/gui/qv2ray-pre.nix { })
    (pkgs.makeAutostartItem { name = "qv2ray"; package = (pkgs.callPackage ./packages/gui/qv2ray-pre.nix) { }; })
    pkgs.v2ray

    pkgs.arion
    pkgs.apfs-fuse
    # https://github.com/HeQuanX/navicat-keygen-tools/blob/main/README.zh-CN.md
    pkgs.appimagekit
    (pkgs.callPackage ./packages/cli/navicat-keygen-tools.nix { })
    pkgs.appimage-run
    pkgs.texlive.combined.scheme-full

    # https://nixos.wiki/wiki/Wine
    pkgs.wineWowPackages.stable
    pkgs.wineWowPackages.fonts
    (pkgs.winetricks.override { wine = pkgs.wineWowPackages.stable; })

    # https://github.com/bkchr/nixos-config/blob/master/system-with-gui-configuration.nix#L8
    pkgs.tdesktop
    (pkgs.makeAutostartItem { name = "telegramdesktop"; package = pkgs.tdesktop; })

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
  ];

  nixpkgs.config.allowUnfree = true;
  imports = [
    ./config/fcitx5.nix
    ./config/git.nix
    ./config/fish.nix
    ./config/neovim.nix
    ./config/zsh.nix

    ./pkgs/ctf.nix
    ./pkgs/fonts.nix
    ./pkgs/gnome.nix
    ./pkgs/browser.nix
    ./pkgs/terminal.nix
    ./pkgs/cli.nix
    ./pkgs/develop.nix
  ];
}
