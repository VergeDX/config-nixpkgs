{ home, pkgs, ... }:
let
  atom-material-theme = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "tobiasalthoff";
      name = "atom-material-theme";
      version = "1.10.7";
      sha256 = "sha256-t5CKrDEbDCuo28wN+hiWrvkt3C9vQAPfV/nd3QBGQ/s=";
    };
  });
  dart = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "dart-code";
      name = "dart-code";
      version = "3.24.2";
      sha256 = "sha256-jSI7zifM62/QfupE1LK2adUJKVhHv4/OCtvuh/qAbbA=";
    };
  });
  flutter = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "dart-code";
      name = "flutter";
      version = "3.24.0";
      sha256 = "sha256-fEFh9idvYYmi/7/VB9pDr2Div3JpqFDaJqHNI9jXClw=";
    };
  });
  github-copilot = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "github";
      name = "copilot";
      version = "1.1.1959";
      sha256 = "sha256-DuYJb1lzqITEpitEFyyXAs7H5NB9o3yXhSBV3CQ0YsI=";
    };
  });
  slidev = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "antfu";
      name = "slidev";
      version = "0.3.2";
      sha256 = "sha256-vzmByEiKZIkd707Bs4RGQrMII5sghYlkQI6aAJOHFcY=";
    };
  });
  tabnine-ai-code-completion = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      # https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode
      publisher = "TabNine";
      name = "tabnine-vscode";
      version = "3.4.13";
      sha256 = "sha256-xsfujEvzAcuHzZL5K6ER6NyEkjaBX1s9gTnCn8wbIWA=";
    };
  });
  terminal = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "formulahendry";
      name = "terminal";
      version = "0.0.10";
      sha256 = "sha256-9hGkD/mWGhwH0ACA3nUD75/XCIi6A8DiDVagfHwPRz4=";
    };
  });
  the-doki-theme = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "unthrottled";
      name = "doki-theme";
      version = "14.0.0";
      sha256 = "sha256-UL/j15dY5Y6FI/2Dr4HG4rAE/BXv3kDHuOc++UATL14=";
    };
  });
in
{
  home.packages = [
    pkgs.gimp-with-plugins
    pkgs.remmina
    (pkgs.callPackage ../packages/gui/motrix.nix { })
    pkgs.zoom-us
    pkgs.google-play-music-desktop-player
    pkgs.qbittorrent
    pkgs.obs-studio
    pkgs.gnome3.baobab

    pkgs.virt-manager
    pkgs.virt-manager-qt
    pkgs.virtualbox

    pkgs.albert
    (pkgs.makeAutostartItem { name = "albert"; package = pkgs.albert; })
    (pkgs.callPackage ../packages/gui/edex-ui.nix { })

    pkgs.libreoffice
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

    pkgs.googleearth
    (pkgs.hiPrio pkgs.googleearth-pro)
    pkgs.wireshark
    pkgs.skypeforlinux

    # https://www.bilibili.com/video/BV17U4y1H7w1
    pkgs.retroarch
    pkgs.dolphinEmu
    pkgs.mame
    pkgs.dosbox

    pkgs.goverlay
    pkgs.okular
    pkgs.zim
    pkgs.kiwix
  ];

  nixpkgs.config.permittedInsecurePackages = [ "ffmpeg-3.4.8" "libav-12.3" ];

  programs.vscode.enable = true;
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    atom-material-theme
    dart
    editorconfig.editorconfig
    flutter
    github-copilot
    eamodio.gitlens
    bbenoist.nix
    jnoortheen.nix-ide
    slidev
    tabnine-ai-code-completion
    terminal
    the-doki-theme
  ] ++ [
    # https://www.youtube.com/watch?v=jQXtpwsWRas
    streetsidesoftware.code-spell-checker
    esbenp.prettier-vscode
    coenraads.bracket-pair-colorizer-2
  ];

  programs.vscode.userSettings = {
    # https://github.com/doki-theme/doki-theme-vscode/tree/master/buildSrc/assets/themes/reZero
    "workbench.colorTheme" = "e828aaae-aa8c-4084-8993-d64697146930";

    # https://copilot.github.com/
    "editor.inlineSuggest.enabled" = true;
    "github.copilot.autocomplete.enable" = true;
    "github.copilot.enable" = {
      "*" = true;
      "yaml" = false;
      "plaintext" = true;
      "markdown" = true;
    };

    # https://github.com/tobiasalthoff/vscode-atom-material-theme#recommended-settings
    "editor.fontSize" = 16;
    "editor.lineHeight" = 1.5;
    "editor.letterSpacing" = 0.5;

    # https://github.com/microsoft/vscode/blob/1.58.0/src/vs/editor/common/config/editorOptions.ts#L3857
    "editor.fontFamily" = "'Jetbrains Mono', 'Hack'";

    # https://dartcode.org/docs/recommended-settings/
    "debug.openDebug" = "openOnDebugBreak";
    "[dart]" = {
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.rulers" = [ 80 ];
      "editor.selectionHighlight" = false;
      "editor.suggest.snippetsPreventQuickSuggestions" = false;
      "editor.suggestSelection" = "first";
      "editor.tabCompletion" = "onlySnippets";
      "editor.wordBasedSuggestions" = false;
    };

    "dart.flutterSdkPath" = "${(pkgs.callPackage ../packages/resources/flutter-vscode.nix { })}";
    # "cSpell.enableFiletypes" = [ "nix" ];
  };

  home.file.".config/Code/User/keybindings.json".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/kasecato/vscode-intellij-idea-keybindings/master/resource/default/Linux/VSCode.json";
    sha256 = "sha256-9nSphycIil5pM0INU6SDzVlqm43LCD5Y9CbQbhVENpQ=";
  };
}
