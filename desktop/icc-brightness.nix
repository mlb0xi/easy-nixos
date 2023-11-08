{ config, lib, pkgs, ... }:

## WORK IN PROGRESS

let
  name = "icc-brightness";
  rev = "587a861d85f3abd102b32282df5206f75bc44cff";
  sha256 = "QyUabPU26eUj1vyoCyjHiDR5M3JCzPzMhctBUWmuLuk=";

in
{
  environment.systemPackages =
  let
    icc-brightness =
      with import <nixpkgs> {};
      stdenv.mkDerivation rec {
        inherit name;

        src = fetchFromGitHub {
          owner = "udifuchs";
          repo = "${name}";
          inherit rev;
          inherit sha256;
        };
        
        nativeBuildInputs = [
          lcms2
        ];

        buildInputs = [
          lcms2
        ];


        installPhase = ''
          mkdir -p $out/bin
          mkdir -p $out/share/gnome/autostart
      
          sed -i "s|BIN_PATH=/usr/local|BIN_PATH=$out|g" ./Makefile          
          sed -i "s|AUTO_START_PATH=/usr|AUTO_START_PATH=$out|g" ./Makefile          

          make install
#          cp icc-brightness-gen $out/usr/local/bin/
#          cp icc-brightness $out/usr/local/bin/
#          cp icc-brightness.desktop $out/usr/share/gnome/autostart/          
        '';

        
      };

  in [
    icc-brightness
  ];    

}
