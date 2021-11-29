{ home, pkgs, ... }:
let formulahendry.terminal = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "formulahendry";
    name = "terminal";
    version = "0.0.10";
    sha256 = "sha256-9hGkD/mWGhwH0ACA3nUD75/XCIi6A8DiDVagfHwPRz4=";
  };
};
in
{
  programs.vscode.enable = true;
  home.packages = [ pkgs.nur.repos.linyinfeng.icalingua ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    tobiasalthoff.atom-material-theme
    editorconfig.editorconfig
    github.copilot
    github.vscode-pull-request-github
    eamodio.gitlens
    ms-vsliveshare.vsliveshare
    bbenoist.nix
    jnoortheen.nix-ide
    antfu.slidev
    mvllow.rose-pine
    tabnine.tabnine-vscode
    dotjoshjohnson.xml
  ] ++ [
    # https://www.youtube.com/watch?v=jQXtpwsWRas
    streetsidesoftware.code-spell-checker
    esbenp.prettier-vscode
    coenraads.bracket-pair-colorizer-2
  ] ++ [ formulahendry.terminal influxdata.flux ]
  ++ [ takayama.vscode-qq ];

  programs.vscode.userSettings = {
    # https://github.com/rose-pine/vscode#:~:text=rose%20pine%20dawn
    "workbench.colorTheme" = "Rosé Pine Dawn";

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

    # https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-telemetry-reporting
    "telemetry.enableTelemetry" = false;
    "workbench.enableExperiments" = false;
    "extensions.autoUpdate" = false;
  };
}
