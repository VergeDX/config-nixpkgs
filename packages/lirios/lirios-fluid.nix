{ stdenv, fetchgit, cmake, libsForQt5, wayland-scanner, ... }:
stdenv.mkDerivation rec {
  pname = "lirios-fluid";
  version = "1.2.0";

  src = fetchgit {
    url = "https://github.com/lirios/fluid";
    rev = "v${version}";
    hash = "sha256-bJQa6UnAJkB5C3n8xNk5K3tykFEVFnOryKMlMTKiX2g=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = [ wayland-scanner.dev ]
    ++ (with libsForQt5; [ qtquickcontrols2 qtgraphicaleffects ]);

  # https://github.com/lirios/fluid/tree/v1.2.0#build
  cmakeFlags = [ "-DFLUID_WITH_DOCUMENTATION:BOOL=OFF" ];

  preFixup = "qtWrapperArgs+=(--prefix QML2_IMPORT_PATH : $out/lib/qml/)";
}