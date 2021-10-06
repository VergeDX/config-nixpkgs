{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.jetbrains.datagrip

    pkgs.android-tools
    pkgs.android-studio
    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui

    pkgs.clang
    pkgs.cmake
    pkgs.ninja

    pkgs.jetbrains.idea-ultimate
    pkgs.jdk11 # pkgs.jetbrains.jdk
    pkgs.kotlin

    pkgs.stack
    pkgs.ghc
    pkgs.haskellPackages.hlint
    pkgs.haskellPackages.hoogle
    pkgs.haskellPackages.ormolu
    pkgs.haskellPackages.stylish-haskell

    pkgs.jetbrains.pycharm-professional
    pkgs.python3Full

    pkgs.jetbrains.clion
    pkgs.cmake
    pkgs.gnumake

    pkgs.maven
    pkgs.gradle

    pkgs.telnet
    pkgs.binwalk
  ] ++ (with pkgs; [ influxdb2 telegraf dasel ]);

  # https://stackoverflow.com/questions/26523804/global-gradle-proxy-settings
  home.file.".gradle/gradle.properties".text = ''
    systemProp.http.proxyHost=127.0.0.1
    systemProp.http.proxyPort=7890
    systemProp.https.proxyHost=127.0.0.1
    systemProp.https.proxyPort=7890
    org.gradle.java.home=${pkgs.jetbrains.jdk}/lib/openjdk
  '';
}
