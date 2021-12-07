{ home, pkgs, lib, ... }:
let myRust = pkgs.rust-bin.nightly.latest.default.override {
  extensions = [ "rust-src" "llvm-tools-preview" ];
  # https://learningos.github.io/rCore-Tutorial-Book-2021Autumn/chapter1/1app-ee-platform.html#id5
  targets = [ "x86_64-unknown-linux-gnu" "riscv64gc-unknown-none-elf" ];
};
in
{
  home.packages = (with pkgs.jetbrains;
    [ datagrip idea-ultimate pycharm-professional clion webstorm ])
  ++ (with pkgs; [ android-studio apktool dex2jar jd-gui ])
  ++ (with pkgs; [ jdk11 kotlin maven gradle ]) # Java & Kotlin
  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#clangd
  ++ (with pkgs; [ cmake gnumake cmake ninja gdb ]) # C / C++
  # https://github.com/oxalica/rust-overlay#usage-examples
  ++ [ myRust pkgs.cargo-binutils ] ++ [ pkgs.cargo-outdated ] # THU - rCore
  ++ [ pkgs.nodePackages."@vue/cli" ] # uni-app
  ++ (with pkgs; [ yarn2nix nodePackages.node2nix neko haxe ])
  ++ lib.singleton (pkgs.python3.withPackages (python-packages: with python-packages;
    ([ pip setuptools ] ++ [ pyserial pyodbc ]
      ++ [ (pkgs.callPackage ../packages/cli/Fildem/Fildem.nix { }) ])));

  # https://npmmirror.com/
  home.file = {
    ".npmrc".text = ''
      registry=https://registry.npmmirror.com/
      home=https://npm.taobao.org
    '';

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
