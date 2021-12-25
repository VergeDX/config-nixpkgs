{ home, pkgs, lib, inputs, system, ... }:
let Fildem = pkgs.callPackage ../packages/cli/Fildem/Fildem.nix { }; in
let cson = pkgs.python3Packages.callPackage ../packages/python3/cson.nix { }; in
{
  home.packages = (with pkgs.jetbrains;
    [ datagrip idea-ultimate pycharm-professional clion webstorm ])
  ++ (with pkgs; [ android-studio apktool dex2jar jd-gui ])
  ++ (with pkgs; [ jdk8 kotlin maven gradle ]) # Java & Kotlin
  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#clangd
  ++ (with pkgs; [ cmake gnumake cmake ninja gdb ]) # C / C++
  ++ (with pkgs.llvmPackages; [ clang ] ++ (with pkgs; [ (lowPrio lldb) ])) # CLion
  ++ [ pkgs.cargo-binutils ] ++ [ pkgs.cargo-outdated ] ++ [ pkgs.rustup ]
  ++ [ pkgs.nodePackages."@vue/cli" ] # uni-app
  ++ (with pkgs; [ yarn2nix nodePackages.node2nix neko haxe ])
  ++ lib.singleton (pkgs.python3.withPackages (python-packages: with python-packages;
    ([ pip setuptools ] ++ [ pyserial pyodbc ] ++ [ Fildem ]
      ++ [ mariadb XlsxWriter pandas ] ++ [ cson docker pylatexenc ])))
  ++ [ (import inputs.nixpkgs-29f57e4 { inherit system; }).pkgs.mysql-workbench ]
  ++ [ pkgs.texlive.combined.scheme-small ]; # https://nixos.wiki/wiki/TexLive

  # https://nix-community.github.io/home-manager/options.html#opt-home.sessionPath
  home.sessionPath = [ "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin" ];
  # https://nix-community.github.io/home-manager/options.html#opt-home.activation
  home.activation."rustup_update" = "${pkgs.rustup}/bin/rustup update &> /dev/null";

  home.file = {
    ".yarnrc".text = ''
      registry "https://registry.npm.taobao.org/"
    '';
  };

  # https://stackoverflow.com/questions/26523804/global-gradle-proxy-settings
  home.file.".gradle/gradle.properties".text = ''
    systemProp.http.proxyHost=127.0.0.1
    systemProp.http.proxyPort=8889
    systemProp.https.proxyHost=127.0.0.1
    systemProp.https.proxyPort=8889
    org.gradle.java.home=${pkgs.jetbrains.jdk}/lib/openjdk
  '';

  home.sessionVariables = {
    # https://stackoverflow.com/questions/11593374/permission-denied-at-hdfs
    "HADOOP_USER_NAME" = "hdfs";
  };
}
