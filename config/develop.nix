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
    pkgs.jetbrains.idea-community
    pkgs.jdk11
    pkgs.kotlin

    pkgs.jetbrains.pycharm-professional
    pkgs.python3Full
    pkgs.conda

    pkgs.jetbrains.clion
    pkgs.cmake
    pkgs.gnumake

    pkgs.maven
    pkgs.gradle
    pkgs.telnet

    # pkgs.eclipses.eclipse-java
    pkgs.eclipses.eclipse-platform
  ];

  # https://stackoverflow.com/questions/26523804/global-gradle-proxy-settings
  home.file.".gradle/gradle.properties".text = ''
    systemProp.http.proxyHost=127.0.0.1
    systemProp.http.proxyPort=8889
    systemProp.https.proxyHost=127.0.0.1
    systemProp.https.proxyPort=8889
    org.gradle.java.home=${pkgs.jetbrains.jdk}/lib/openjdk
  '';
}
