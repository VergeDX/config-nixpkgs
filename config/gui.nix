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
  github-copilot = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "github";
      name = "copilot";
      version = "1.1.1959";
      sha256 = "sha256-DuYJb1lzqITEpitEFyyXAs7H5NB9o3yXhSBV3CQ0YsI=";
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
    # pkgs.googleearth-pro
  ];

  programs.vscode.enable = true;
  programs.vscode.extensions = [
    atom-material-theme
    pkgs.vscode-extensions.editorconfig.editorconfig
    github-copilot
    pkgs.vscode-extensions.bbenoist.Nix
    pkgs.vscode-extensions.jnoortheen.nix-ide
    terminal
    the-doki-theme
  ];

  programs.vscode.userSettings = {
    "editor.fontFamily" = "'Jetbrains Mono', 'Hack', 'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback'";
    "editor.fontSize" = 16;
    "editor.inlineSuggest.enabled" = true;
    "editor.letterSpacing" = 0.5;
    "editor.lineHeight" = 1.5;
    "github.copilot.autocomplete.enable" = true;
    "github.copilot.enable" = {
      "*" = true;
      "yaml" = false;
      "plaintext" = true;
      "markdown" = false;
    };
    "workbench.colorTheme" = "e828aaae-aa8c-4084-8993-d64697146930";
  };
}
