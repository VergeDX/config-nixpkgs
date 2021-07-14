{ stdenv
, fetchFromGitHub
, cmake
, libsForQt5
, copyDesktopItems
, android-tools
, makeDesktopItem
, lib
}:

stdenv.mkDerivation rec {
  pname = "qtscrcpy";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "barry-ran";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-2d7AIUra7Uc/N0Ako8JYo07GUTPNgorxl2hmeDJOGPU=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook copyDesktopItems ];
  buildInputs = with libsForQt5.qt5 ;[ qttools.dev qtx11extras.dev ];

  patchPhase = ''
    sed -i 's@"../../../third_party/adb/linux/adb"@"${android-tools.out}/bin/adb"@g' ./QtScrcpy/main.cpp
    sed -i 's@"../../../third_party/scrcpy-server"@"'"$out"'/scrcpy-server"@g' ./QtScrcpy/main.cpp
  '';

  installPhase = ''
    mkdir -p $out/bin/
    cp /build/source/output/linux/release/QtScrcpy $out/bin/
    cp /build/source/third_party/scrcpy-server $out/
    runHook postInstall
  '';

  # https://aur.archlinux.org/cgit/aur.git/tree/qtscrcpy.desktop?h=qtscrcpy
  desktopItems = [
    (makeDesktopItem {
      name = pname;
      type = "Application";
      icon = "qtscrcpy";
      desktopName = "QtScrcpy";
      exec = "QtScrcpy";
      terminal = false;
      categories = "Development;Utility";
      comment = "Android real-time screencast control tool";
    })
  ];

  meta = with lib; {
    description = "Android real-time display control software";
    homepage = "https://github.com/barry-ran/QtScrcpy";
    license = licenses.asl20;
    maintainers = [ maintainers.vanilla ];
    platforms = platforms.linux;
  };
}
