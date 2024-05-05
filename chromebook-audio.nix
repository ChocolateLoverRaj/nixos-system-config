{ config, pkgs, lib, ... }:


let
  chromebook-ucm-conf = with pkgs; alsa-ucm-conf.overrideAttrs {
    wttsrc = fetchFromGitHub {
      owner = "WeirdTreeThing";
      repo = "chromebook-ucm-conf";
      rev = "b6ce2a7";
      hash = "sha256-QRUKHd3RQmg1tnZU8KCW0AmDtfw/daOJ/H3XU5qWTCc=";
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
      maliit-keyboard
      sof-firmware
    ];
    sessionVariables.ALSA_CONFIG_UCM2 = "${chromebook-ucm-conf}/share/alsa/ucm2";
  };

  system.replaceRuntimeDependencies = with pkgs; [
    ({
      original = alsa-ucm-conf;
      replacement = chromebook-ucm-conf;
    })
  ];

  # For nixos unstable
  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-increase-headroom.lua" ''
      monitor.alsa.rules = [
        {
          matches = [
            {
              node.name = "~alsa_output.*"
            }
          ]
          actions = {
            update-props = {
              api.alsa.headroom = 4096
            }
          }
        }
      ]
    '')
  ];
}
