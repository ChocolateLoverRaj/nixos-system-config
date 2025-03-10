{
  config,
  pkgs,
  lib,
  ...
}:

let
  chromebook-ucm-conf =
    with pkgs;
    alsa-ucm-conf.overrideAttrs {
      wttsrc = fetchFromGitHub {
        owner = "WeirdTreeThing";
        repo = "alsa-ucm-conf-cros";
        rev = "5b4253786ac0594a6ae9fe06336b54d8bc66efb0";
        hash = "sha256-CeZtEA2Wq0zle/3OHbob2GDH4ffczGqZ2qVItKME5eI=";
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
