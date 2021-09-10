let
  pkgs = import <nixpkgs> { };
  cutefish-core = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-core";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/core";
      rev = version;
      sha256 = "sha256-sXOznqS2TO6Z4rlkQz2cBe+2JuuCL5upK5T1kY8/DI4=";
    };

    # https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/desktops/xfce/core/xfce4-settings/default.nix#L14
    patchPhase = ''
      sed -i 's/polkit-agent-1/polkit-qt5-agent-1/g' polkit-agent/CMakeLists.txt
      sed -i 's@"libinput-properties.h"@<xorg/libinput-properties.h>@g' settings-daemon/mouse/x11libinputdummydevice.cpp
      sed -i 's@<libinput-properties.h>@<xorg/libinput-properties.h>@g' settings-daemon/mouse/x11libinputdummydevice.cpp
    '';

    nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config ];
    dontWrapQtApps = true;
    buildInputs = [
      pkgs.libsForQt5.qt5.qtbase
      pkgs.libsForQt5.qt5.qtquickcontrols
      pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.qt5.qtx11extras
      pkgs.libsForQt5.qt5.qttools
      pkgs.extra-cmake-modules
      pkgs.libsForQt5.polkit-qt
      pkgs.libsForQt5.kwindowsystem
      pkgs.pcre
      pkgs.pulseaudio
      pkgs.xorg.xf86inputlibinput
      pkgs.xorg.libXdmcp
      pkgs.xorg.libSM
      pkgs.xorg.libXtst
      pkgs.xorg.libXcursor
    ];

    installPhase = ''
      sed -i 's@/etc/xdg/autostart@'"$out"'/etc/xdg/autostart@g' polkit-agent/cmake_install.cmake
      sed -i 's@/var/empty@'"$out"'@g' polkit-agent/cmake_install.cmake
      sed -i 's@/var/empty@'"$out"'@g' cpufreq/cmake_install.cmake
      sed -i 's@/var/empty@'"$out"'@g' screen-brightness/cmake_install.cmake
      sed -i 's@/var/empty@'"$out"'@g' session/cmake_install.cmake
      sed -i 's@/var/empty@'"$out"'@g' settings-daemon/cmake_install.cmake
      sed -i 's@/var/empty@'"$out"'@g' shutdown-ui/cmake_install.cmake
      make install
    '';
  };
in
cutefish-core
