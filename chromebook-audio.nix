{ config, pkgs, lib, ... }:


let
  chromebook-ucm-conf = with pkgs; alsa-ucm-conf.overrideAttrs {
    wttsrc = fetchFromGitHub {
      owner = "WeirdTreeThing";
      repo = "chromebook-ucm-conf";
      rev = "ddeafa85ed36e31aed1c05ca6987ee125c52f238";
      hash = "sha256-Y/lu570acQ8ejdfUKL3l/DR3BdUofv/HwuPFVaxbLB4=";
    };
    postInstall = ''
      cp -R $wttsrc/common/* $out/share/alsa/ucm2/common
      cp -R $wttsrc/codecs/* $out/share/alsa/ucm2/codecs
      cp -R $wttsrc/platforms/* $out/share/alsa/ucm2/platforms
      cp -R $wttsrc/sof-rt5682 $out/share/alsa/ucm2/conf.d
      cp -R $wttsrc/sof-cs42l42 $out/share/alsa/ucm2/conf.d
    '';
  };
in
{
  environment = {
    systemPackages = with pkgs; [
      sof-firmware
    ];
    sessionVariables.ALSA_CONFIG_UCM2 = "${chromebook-ucm-conf}/share/alsa/ucm2";
  };

  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-increase-headroom.conf" ''
      monitor.alsa.rules = [
        {
          matches = [
            {
              node.name = "~alsa_output.*"
            }
          ]
          actions = {
            update-props = {
              api.alsa.headroom = 8192
            }
          }
        }
      ]
    '')
  ];
}
