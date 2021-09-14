{ home, pkgs, ... }:
let home_dir = "/home/vanilla";
in
{
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${home_dir}/.nix-profile/lib/pkgconfig:${home_dir}/.nix-profile/share/pkgconfig";
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
  };

  home.packages = [
    pkgs.android-tools
    pkgs.android-studio
    # pkgs.androidStudioPackages.canary
    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui

    pkgs.clang
    pkgs.cmake
    pkgs.ninja

    pkgs.jetbrains-mono

    pkgs.jetbrains.rider
    pkgs.dotnet-sdk
    pkgs.mono
    (pkgs.hiPrio pkgs.msbuild)
    pkgs.dotnetPackages.Nuget

    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.jdk
    pkgs.kotlin

    pkgs.jetbrains.pycharm-professional
    pkgs.python3Full

    pkgs.jetbrains.clion
    pkgs.cmake
    pkgs.gnumake

    pkgs.maven
    pkgs.gradle
  ];
}
