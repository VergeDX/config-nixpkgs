{ home, pkgs, ... }:
let
  tobiasalthoff.atom-material-theme = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "tobiasalthoff";
      name = "atom-material-theme";
      version = "1.10.7";
      sha256 = "sha256-t5CKrDEbDCuo28wN+hiWrvkt3C9vQAPfV/nd3QBGQ/s=";
    };
  });
  GitHub.copilot = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "github";
      name = "copilot";
      version = "1.4.2635";
      sha256 = "sha256-yhzM3d8yZMARAZVmO3zqgD8ucusiBOZVaI7NPlcaddM=";
    };
  });
  antfu.slidev = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "antfu";
      name = "slidev";
      version = "0.3.2";
      sha256 = "sha256-vzmByEiKZIkd707Bs4RGQrMII5sghYlkQI6aAJOHFcY=";
    };
  });
  TabNine.tabnine-vscode = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      # https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode
      publisher = "TabNine";
      name = "tabnine-vscode";
      version = "3.4.26";
      sha256 = "sha256-OEdc03X8EX9k2V8dO8gOOLpIaNrlituunRewZtcvlBI=";
    };
  });
  formulahendry.terminal = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "formulahendry";
      name = "terminal";
      version = "0.0.10";
      sha256 = "sha256-9hGkD/mWGhwH0ACA3nUD75/XCIi6A8DiDVagfHwPRz4=";
    };
  });
in
{
  programs.vscode.enable = true;
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    tobiasalthoff.atom-material-theme
    editorconfig.editorconfig
    GitHub.copilot
    github.vscode-pull-request-github
    eamodio.gitlens
    bbenoist.nix
    jnoortheen.nix-ide
    antfu.slidev
    TabNine.tabnine-vscode
    formulahendry.terminal
    dotjoshjohnson.xml
  ] ++ [
    # https://www.youtube.com/watch?v=jQXtpwsWRas
    streetsidesoftware.code-spell-checker
    esbenp.prettier-vscode
    coenraads.bracket-pair-colorizer-2
  ];

  programs.vscode.userSettings = {
    "workbench.colorTheme" = "";

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

    "update.mode" = "none";

    # https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-telemetry-reporting
    "telemetry.enableTelemetry" = false;
    "workbench.enableExperiments" = false;
    "extensions.autoUpdate" = false;
  };
}
