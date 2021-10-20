{ home, pkgs, ... }:
let useJbJdk = pkgsJb: pkgsJb.overrideAttrs (old: { jdk = pkgs.jetbrains.jdk; });
in
{
  home.packages = (builtins.map useJbJdk (with pkgs.jetbrains;
    [ datagrip idea-ultimate pycharm-professional clion ]))
  ++ (with pkgs; [ android-tools android-studio apktool dex2jar jd-gui ])
  ++ (with pkgs; [ jdk11 kotlin maven gradle ]) # Java & Kotlin
  ++ (with pkgs; [ python2Full python3Full sqlite sqlitebrowser ]) # Python 3
  ++ (with pkgs.python3Packages; [ pylint pylint-django ]) # Pylint
  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#clangd
  ++ (with pkgs; [ cmake gnumake llvmPackages_9.libclang cmake ninja ]) # C / C++
  ++ [ pkgs.clang_9 pkgs.gdb pkgs.llvmPackages_9.lldb ] # For CLion.
  ++ (with pkgs.rust-bin.stable.latest; [ default rust-src ]); # Rust

  # https://stackoverflow.com/questions/26523804/global-gradle-proxy-settings
  home.file.".gradle/gradle.properties".text = ''
    systemProp.http.proxyHost=127.0.0.1
    systemProp.http.proxyPort=8889
    systemProp.https.proxyHost=127.0.0.1
    systemProp.https.proxyPort=8889
    org.gradle.java.home=${pkgs.jetbrains.jdk}/lib/openjdk
  '';
}
