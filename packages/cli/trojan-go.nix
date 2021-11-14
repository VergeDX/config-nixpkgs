{ buildGo117Module, fetchgit, ... }:
buildGo117Module rec {
  pname = "trojan-go";
  version = "0.10.6";

  src = fetchgit {
    url = "https://github.com/p4gefau1t/${pname}";
    rev = "v${version}";
    sha256 = "sha256-ZzIEKyLhHwYEWBfi6fHlCbkEImetEaRewbsHQEduB5Y=";
  };

  vendorSha256 = "sha256-c6H/8/dmCWasFKVR15U/kty4AzQAqmiL/VLKrPtH+s4=";
  preBuild = ''
    rm ./common/geodata/decode_test.go
    rm ./test/scenario/custom_test.go
    rm ./test/scenario/proxy_test.go
    rm ./tunnel/shadowsocks/shadowsocks_test.go
  '';

  # https://github.com/p4gefau1t/trojan-go/blob/v0.10.6/Makefile#L9
  tags = [ "full" ];
}
