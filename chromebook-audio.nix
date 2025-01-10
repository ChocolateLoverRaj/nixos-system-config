{ config, pkgs, lib, ... }:


let
  chromebook-ucm-conf = with pkgs; alsa-ucm-conf.overrideAttrs {
    wttsrc = fetchFromGitHub {
      owner = "WeirdTreeThing";
      repo = "alsa-ucm-conf-cros";
      rev = "00b399ed00930bfe544a34358547ab20652d71e3";
      hash = "sha256-lRrgZDb3nnZ6/UcIsfjqAAbbSMOkP3lBGoGzZci+c1k=";
    };
    postInstall = ''
      cp -R $wttsrc/ucm2/* $out/share/alsa/ucm2
      cp -R $wttsrc/overrides/* $out/share/alsa/ucm2/conf.d
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
