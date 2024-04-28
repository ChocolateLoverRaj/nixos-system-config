{ config, pkgs, lib, ... }:


let
  adl-ucm-conf = with pkgs; alsa-ucm-conf.overrideAttrs {
    wttsrc = fetchFromGitHub {
      owner = "WeirdTreeThing";
      repo = "chromebook-ucm-conf";
      rev = "1328e46bfca6db2c609df9c68d37bb418e6fe279";
      hash = "sha256-DDQgIgVyA+Kj5Di8aMltkk3dM0VIeT9/H0/+iL6IPMU=";
    };
    unpackPhase = ''
      runHook preUnpack

      tar xf "$src"

      runHook postUnpack
    '';
    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/alsa
      cp -r alsa-ucm*/{ucm,ucm2} $out/share/alsa
      cp -r $wttsrc/common $out/share/alsa/ucm2
      cp -r $wttsrc/cml/* $out/share/alsa/ucm2/conf.d

      runHook postInstall
    '';
  };
in
{
  boot = {
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=3
    '';
  };

  environment = {
    systemPackages = with pkgs; [
      maliit-keyboard
      sof-firmware
    ];
    sessionVariables.ALSA_CONFIG_UCM2 = "${adl-ucm-conf}/share/alsa/ucm2";
    # For nixos 23.11
    # etc = {
    #   "wireplumber/main.lua.d/51-increase-headroom.lua".text = ''
    #     rule = {
    #       matches = {
    #         {
    #           { "node.name", "matches", "alsa_output.*" },
    #         },
    #       },
    #       apply_properties = {
    #         ["api.alsa.headroom"] = 4096,
    #       },
    #     }

    #     table.insert(alsa_monitor.rules,rule)
    #   '';
    # };
  };

  system.replaceRuntimeDependencies = with pkgs; [
    ({
      original = alsa-ucm-conf;
      replacement = adl-ucm-conf;
    })
  ];

  # For nixos unstable
  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/main.lua.d/51-increase-headroom.lua" ''
      rule = {
        matches = {
          {
            { "node.name", "matches", "alsa_output.*" },
          },
        },
        apply_properties = {
          ["api.alsa.headroom"] = 4096,
        },
      }

      table.insert(alsa_monitor.rules,rule)
    '')
  ];
}
