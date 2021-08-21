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
  programs.vscode.enable = true;
  programs.vscode.package =
    if pkgs.stdenv.isDarwin # Using nix-darwin install gui programs.
    then (pkgs.runCommand "" { pname = "vscode"; } "mkdir $out")
    else pkgs.vscode;

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
    dotjoshjohnson.xml
  ] ++ [
    # https://www.youtube.com/watch?v=jQXtpwsWRas
    streetsidesoftware.code-spell-checker
    esbenp.prettier-vscode
    coenraads.bracket-pair-colorizer-2
  ];

  programs.vscode.userSettings = {
    # https://github.com/doki-theme/doki-theme-vscode/tree/master/buildSrc/assets/themes/reZero
    # "workbench.colorTheme" = "e828aaae-aa8c-4084-8993-d64697146930";
    "window.autoDetectColorScheme" = true;
    "workbench.preferredLightColorTheme" = "e828aaae-aa8c-4084-8993-d64697146930";
    "workbench.preferredDarkColorTheme" = "696de7c1-3a8e-4445-83ee-3eb7e9dca47f";

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

    "update.mode" = "none";

    # https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-telemetry-reporting
    "telemetry.enableTelemetry" = false;
    "workbench.enableExperiments" = false;
    "extensions.autoUpdate" = false;
  };
}
