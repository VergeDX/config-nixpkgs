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

    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.nodePackages.npm-check-updates
    # https://nixos.wiki/wiki/Node.js
    pkgs.yarn
    pkgs.yarn2nix
    (pkgs.callPackage ../packages/cli/pxder/pxder.nix { })
    pkgs.gh
    pkgs.speedtest-cli

    pkgs.pciutils
    pkgs.gping
    (pkgs.callPackage ../packages/cli/startrinity.nix { })
  ];
}
