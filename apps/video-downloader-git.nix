{ config, lib, pkgs, ... }:

let
  pname = "video-downloader";
  version = "v0.12.9";
  rev = "41f5f7f4555f47f00149d419733146f82e7f13d6";
  sha256 = "3eJQg7GAv5r0yCSj4A8k2Zhfbawzax7x4CZAyg3lU0Y=";

  python =
    with import <nixpkgs> {};
    python3.withPackages (ps : with ps; [ pygobject3 yt-dlp ]);

in
{
  environment.systemPackages =
  let
    video-downloader =
      with import <nixpkgs> {};
      stdenv.mkDerivation rec {
        inherit pname;
        inherit version;

        src = fetchFromGitHub {
          owner = "Unrud";
          repo = "${pname}";
          inherit rev;
          inherit sha256;
        };
        
        nativeBuildInputs = [
          desktop-file-utils
          appstream-glib
          meson
          ninja
          pkg-config
          python3
          wrapGAppsHook4
        ];

        buildInputs = [
          gtk4
          libadwaita
          haskellPackages.gi-gdk
          haskellPackages.gi-gtk
          yt-dlp
          ffmpeg
        ];

        preFixup = ''
          wrapProgram $out/bin/$pname \
            --prefix PYTHONPATH : ${python}/${python.sitePackages} \
        '';
        
      };

  in [
    video-downloader
  ];    

}
