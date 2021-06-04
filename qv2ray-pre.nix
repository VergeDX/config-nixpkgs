let
  pkgs = import <nixpkgs> { };
  qv2ray-pre = pkgs.qv2ray.overrideAttrs (old: {
    version = "v2.7.0-pre2";

    src = pkgs.fetchgit {
      url = "https://github.com/Qv2ray/Qv2ray.git";
      rev = "v2.7.0-pre2";

      # sha256 = pkgs.lib.fakeSha256;
      # sha256 = "sha256:0jx7x1xrc4mg6b8hy22hmfbimf1zanlym2zbdlcinrz0jkxrraif"; | v2.7.0-alpha1
      # sha256 = "sha256:082izi1jls0yv1lrv6fbam4bkab5p3fzw9yxspigv9fisr39nlrz"; | v2.7.0-pre1
      sha256 = "sha256:0qyzn9ssng4lmlz923hvx9lrc80nphh6k96irvwsj5brnj4zph2j";
    };

    buildInputs = old.buildInputs ++ [ pkgs.curl ];
  });
in
qv2ray-pre
