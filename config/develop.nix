{ home, pkgs, ... }:
let
  useJbJdk = pkgsJb: pkgsJb.overrideAttrs (old: {
    jdk = pkgs.jetbrains.jdk;
  });
in
{
  home.packages = (builtins.map useJbJdk (with pkgs.jetbrains;
    [ datagrip idea-ultimate pycharm-professional clion ]))
  ++ (with pkgs; [ android-tools android-studio apktool dex2jar jd-gui ])
  ++ (with pkgs; [ jdk11 kotlin maven gradle ]) # Java & Kotlin
  ++ (with pkgs; [ python2Full python3Full ]) # Python 3
  ++ (with pkgs; [ cmake gnumake clang cmake ninja ]); # C / C++

  # https://stackoverflow.com/questions/26523804/global-gradle-proxy-settings
  home.file.".gradle/gradle.properties".text = ''
    systemProp.http.proxyHost=127.0.0.1
    systemProp.http.proxyPort=7890
    systemProp.https.proxyHost=127.0.0.1
    systemProp.https.proxyPort=7890
    org.gradle.java.home=${pkgs.jetbrains.jdk}/lib/openjdk
  '';
}
