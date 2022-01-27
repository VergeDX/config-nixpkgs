{ home, pkgs, ... }:
let unzip-fixed = pkgs.callPackage ../packages/patches/unzip-fixed.nix { }; in
let sg_cli = pkgs.callPackage ../packages/rust/sg_cli.nix { }; in
let nix-user-chroot = pkgs.callPackage ../packages/rust/nix-user-chroot.nix { }; in
let distrobox = pkgs.callPackage ../packages/cli/distrobox.nix { }; in
{
  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome // {
        file-roller = super.gnome.file-roller.override { unzip = unzip-fixed; };
      };
    })
  ];

  home.packages = [
    unzip-fixed
    # pkgs.unzip

    pkgs.scrcpy
    pkgs.glxinfo
    pkgs.mr
    pkgs.tree
    pkgs.translate-shell
    pkgs.wget

    pkgs.htop
    pkgs.bpytop
    pkgs.btop

    (pkgs.callPackage ../packages/fcitx/ssf2fcitx.nix { })
    pkgs.checkra1n
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
    pkgs.xsel

    # https://nixos.wiki/wiki/Node.js
    pkgs.yarn
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
    pkgs.iperf
    (pkgs.callPackage ../packages/cli/trojan-go.nix { })
    pkgs.ipinfo

    pkgs.raspberrypi-eeprom
    pkgs.libraspberrypi

    pkgs.kalker
    # https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7
    pkgs.openssl

    # https://github.com/migueravila/Flowetch
    pkgs.rpm
    pkgs.bc
  ] ++ [ pkgs.nixos-generators ]
  ++ [ sg_cli nix-user-chroot ]
  ++ [ pkgs.ffmpeg ] ++ [ pkgs.powershell ]
  ++ [ pkgs.vitetris ] # `tetris`!
  ++ [ distrobox ]
  ++ [ pkgs.nodePackages.fkill-cli ];

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
  programs.nix-index.enableBashIntegration = false;
  programs.nix-index.enableZshIntegration = false;

  programs.tmux.enable = true;
  # https://wiki.archlinux.org/title/Tmux#Setting_the_correct_term
  # https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
  programs.tmux.extraConfig = ''
    set -ga terminal-overrides ",xterm:Tc"
    set -sg escape-time 10
  '';

  home.file.".dolt/config_global.json".text = builtins.toJSON {
    "user.email" = "osu_Vanilla@126.com";
    "user.name" = "Vanilla";
  };
}
