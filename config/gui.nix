{ home, pkgs, ... }:
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
    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        publisher = "tobiasalthoff";
        name = "atom-material-theme";
        version = "1.10.7";
        sha256 = "sha256-t5CKrDEbDCuo28wN+hiWrvkt3C9vQAPfV/nd3QBGQ/s=";
      };
    })
    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        publisher = "github";
        name = "copilot";
        version = "1.1.1959";
        sha256 = "sha256-DuYJb1lzqITEpitEFyyXAs7H5NB9o3yXhSBV3CQ0YsI=";
      };
    })
    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        publisher = "unthrottled";
        name = "doki-theme";
        version = "14.0.0";
        sha256 = "sha256-UL/j15dY5Y6FI/2Dr4HG4rAE/BXv3kDHuOc++UATL14=";
      };
    })
    pkgs.vscode-extensions.bbenoist.Nix
    pkgs.vscode-extensions.jnoortheen.nix-ide
  ];

  programs.vscode.userSettings = {
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
