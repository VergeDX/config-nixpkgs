{ home, pkgs, ... }:
let home_dir = "/home/vanilla";
in
{
  # https://nixos.org/manual/nix/unstable/expressions/builtins.html
  home.file.".config/flutter/settings".text = builtins.toJSON {
    "enable-linux-desktop" = true;
    "android-sdk" = "${pkgs.androidenv.androidPkgs_9_0.platform-tools}libexec/";
  };

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${home_dir}/.nix-profile/lib/pkgconfig:${home_dir}/.nix-profile/share/pkgconfig";
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";

    # https://mirrors.bfsu.edu.cn/help/flutter/
    FLUTTER_STORAGE_BASE_URL = "https://mirrors.bfsu.edu.cn/flutter";
    PUB_HOSTED_URL = "https://mirrors.bfsu.edu.cn/dart-pub";
  };

  home.packages = [
    pkgs.android-tools
    pkgs.android-studio
    pkgs.androidStudioPackages.canary
    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui

    pkgs.dart
    (pkgs.callPackage ../packages/override/flutter-override.nix { })
    pkgs.clang
    pkgs.cmake
    pkgs.ninja
    pkgs.pkg-config

    pkgs.jetbrains-mono
    pkgs.jetbrains.rider
    pkgs.dotnet-sdk
    pkgs.mono
    (pkgs.hiPrio pkgs.msbuild)
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.jdk
    pkgs.kotlin
    pkgs.jetbrains.goland
    pkgs.go
    pkgs.jetbrains.pycharm-professional
    pkgs.python3Full
    pkgs.jetbrains.clion
    pkgs.cmake
    pkgs.gnumake

    pkgs.maven
    pkgs.gradle
  ];
}
