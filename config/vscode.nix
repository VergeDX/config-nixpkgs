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
      version = "1.4.2635";
      sha256 = "sha256-yhzM3d8yZMARAZVmO3zqgD8ucusiBOZVaI7NPlcaddM=";
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
      version = "3.4.26";
      sha256 = "sha256-OEdc03X8EX9k2V8dO8gOOLpIaNrlituunRewZtcvlBI=";
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
      version = "15.3.0";
      sha256 = "sha256-uQfPN0NVrRh0a5owfrhKJU7w1Ci6N08/JjbqEM3sVps=";
    };
  });
in
{
  programs.vscode.enable = true;
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    atom-material-theme
    editorconfig.editorconfig
    github-copilot
    eamodio.gitlens
    bbenoist.nix
    jnoortheen.nix-ide
    slidev
    tabnine-ai-code-completion
    terminal
    the-doki-theme
    dotjoshjohnson.xml
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

    "update.mode" = "none";

    # https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-telemetry-reporting
    "telemetry.enableTelemetry" = false;
    "workbench.enableExperiments" = false;
    "extensions.autoUpdate" = false;
  };
}
