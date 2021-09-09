{ qv2ray, fetchgit, curl }:
qv2ray.overrideAttrs (old: {
  version = "v2.7.0";

  src = fetchgit {
    url = "https://github.com/Qv2ray/Qv2ray.git";
    rev = "v2.7.0";
    sha256 = "sha256-afFTGX/zrnwq/p5p1kj+ANU4WeN7jNq3ieeW+c+GO5M=";
  };

  buildInputs = old.buildInputs ++ [ curl ];
})
