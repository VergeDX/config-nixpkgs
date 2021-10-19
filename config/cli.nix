{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.unzip
    pkgs.scrcpy
    pkgs.glxinfo
    pkgs.mr
    pkgs.tree
    pkgs.translate-shell
    pkgs.wget

    pkgs.htop
    pkgs.bpytop

    (pkgs.callPackage ../packages/fcitx/ssf2fcitx.nix { })
    pkgs.checkra1n
    pkgs.p7zip
    pkgs.slides
    pkgs.file
    pkgs.ncdu
    pkgs.lsd
    pkgs.screen
    pkgs.idevicerestore
    pkgs.usbutils
    pkgs.hub
    pkgs.du-dust

    pkgs.nodejs_latest # pkgs.nodePackages.npm
    pkgs.nodePackages.npm-check-updates
    pkgs.nodePackages.clipboard-cli

    # https://nixos.wiki/wiki/Node.js
    pkgs.yarn
    pkgs.yarn2nix
    pkgs.nodePackages.pxder

    pkgs.gh
    pkgs.speedtest-cli

    pkgs.pciutils
    pkgs.gping

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
    pkgs.unrar
    pkgs.hydra-check

    pkgs.dmg2img
    # https://github.com/helix-editor/helix
    pkgs.helix

    pkgs.dig
    pkgs.nmap
    pkgs.raspberrypi-eeprom
    pkgs.libraspberrypi

    pkgs.kalker
    # https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7
    pkgs.openssl
  ];

  # https://nix-community.github.io/home-manager/options.html
  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  manual.html.enable = true;
  manual.manpages.enable = true;

  # https://github.com/chinanf-boy/bat-zh
  programs.bat.enable = true;
  programs.bat.config = { theme = "Solarized (light)"; };
  # programs.fish.shellAliases = { cat = "bat"; };

  # https://github.com/jesseduffield/lazygit
  programs.lazygit.enable = true;
  programs.lazygit.settings = { gui.theme = { lightTheme = true; }; };
  programs.fish.shellAliases = { lg = "lazygit"; };

  # https://github.com/bennofs/nix-index
  programs.nix-index.enable = true;

  programs.tmux.enable = true;
  # https://wiki.archlinux.org/title/Tmux#Setting_the_correct_term
  programs.tmux.extraConfig = ''set -ga terminal-overrides ",xterm:Tc"'';
}
