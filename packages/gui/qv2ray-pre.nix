{ qv2ray, fetchgit, curl }:
qv2ray.overrideAttrs (old: {
  version = "v2.7.0-pre2";

  src = fetchgit {
    url = "https://github.com/Qv2ray/Qv2ray.git";
    rev = "v2.7.0-pre2";
    sha256 = "sha256:0qyzn9ssng4lmlz923hvx9lrc80nphh6k96irvwsj5brnj4zph2j";
  };

  buildInputs = old.buildInputs ++ [ curl ];
})
