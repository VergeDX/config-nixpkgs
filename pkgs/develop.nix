{ home, pkgs, ... }:
{
  home.file.".config/flutter/settings".text = ''{ "enable-linux-desktop": true }'';
  home.packages = [
    pkgs.android-studio
    pkgs.androidStudioPackages.canary
    # pkgs.android-tools
    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui

    pkgs.flutter
    pkgs.clang
    pkgs.cmake
    pkgs.ninja
    pkgs.pkg-config

    pkgs.jetbrains.rider
    pkgs.dotnet-sdk
    pkgs.mono
    pkgs.jetbrains.idea-ultimate
    pkgs.jdk11
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
