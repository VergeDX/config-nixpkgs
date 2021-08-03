{ home, pkgs, ... }:
{
  home.packages = [
    # https://nixos.wiki/wiki/Nvidia
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec -a "$0" "$@"
    '')

    pkgs.unzip
    pkgs.scrcpy
    pkgs.glxinfo
    pkgs.mr
    pkgs.tree
    pkgs.translate-shell
    pkgs.wget
    pkgs.htop
    (pkgs.callPackage ../packages/fcitx/ssf2fcitx.nix { })
    (pkgs.callPackage ../packages/cli/checkra1n.nix { })
    pkgs.p7zip
    pkgs.slides
    pkgs.file
    pkgs.ncdu
    pkgs.lsd
    pkgs.screen
    pkgs.tmux
    pkgs.idevicerestore
    pkgs.usbutils
    (pkgs.callPackage ../packages/cli/xsp.nix { })
    pkgs.hub
    pkgs.du-dust

    pkgs.nodejs_latest
    (pkgs.lowPrio pkgs.nodePackages.npm)
    pkgs.nodePackages.npm-check-updates
    # https://nixos.wiki/wiki/Node.js
    pkgs.yarn
    pkgs.yarn2nix
    pkgs.nodePackages.pxder
    pkgs.gh
    pkgs.speedtest-cli

    pkgs.pciutils
    pkgs.gping
    (pkgs.callPackage ../packages/cli/startrinity.nix { })

    pkgs.nvchecker
    pkgs.nvfetcher

    pkgs.dolt
    (pkgs.callPackage ../packages/cli/colorized-logs.nix { })
    pkgs.niv

    pkgs.youtube-dl
    pkgs.you-get
    pkgs.mps-youtube

    pkgs.libva-utils
    pkgs.vdpauinfo
    pkgs.lshw

    pkgs.ncspot
  ];

  # https://nvchecker.readthedocs.io/en/latest/usage.html#install-and-run
  # https://nvchecker.readthedocs.io/en/latest/usage.html#check-github
  home.file.".config/nvchecker/nvchecker.toml".source =
    let source-github = g: { source = "github"; github = g; use_max_tag = true; };
    in
    (pkgs.formats.toml { }).generate "nvchecker.toml" {
      nvchecker = source-github "lilydjwg/nvchecker";
      python-toml = { source = "pypi"; pypi = "toml"; };

      # https://github.com/NixOS/nixpkgs/search?q=maintainers.vanilla
      gpick = source-github "thezbyg/gpick";
      layan-gtk-theme = source-github "vinceliuice/Layan-gtk-theme";
      flat-remix-gnome = source-github "daniruiz/flat-remix-gnome";
    };

  # https://nix-community.github.io/home-manager/options.html
  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  manual.html.enable = true;
  manual.manpages.enable = true;

  # https://github.com/chinanf-boy/bat-zh
  programs.bat.enable = true;
  programs.fish.shellAliases = { cat = "bat"; };

  # https://github.com/Canop/broot
  programs.broot.enable = true;
  programs.broot.enableFishIntegration = true;

  # https://github.com/jesseduffield/lazygit
  programs.lazygit.enable = true;
  programs.lazygit.settings = { gui.theme = { lightTheme = true; }; };
  programs.fish.shellAliases = { lg = "lazygit"; };

  # https://github.com/bennofs/nix-index
  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;
}
