{ pkgs, config, lib, ... }:

let
  maintain-charge = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "maintain-charge";
    version = "0.1.0";
    cargoHash = "sha256-tFvEMKAzkauhW2bztKNhOfrPwAXb8duBgpPxbd14ElQ=";
    src = fetchFromGitHub {
      owner = "ChocolateLoverRaj";
      repo = "maintain-charge";
      rev = "c0b24db5f2b81617aa12df7cfa5d51a971adb9de";
      hash = "sha256-c8RbnSiyAktRRl8aIJ0s0l8WYguUCQaprHzkmxnCDkw=";
    };
  };
in
{
  options.maintain-charge = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    minPercent = lib.mkOption {
      type = lib.types.int;
      default = 41;
    };
    maxPercent = lib.mkOption {
      type = lib.types.int;
      default = 59;
    };
  };

  config = {
    systemd = {
      services = {
        maintain-charge = {
          enable = config.maintain-charge.enable;
          description = "Keep battery between 40% to 60%";
          serviceConfig = {
            Type = "exec";
            ExecStart = "${maintain-charge}/bin/maintain-charge ${toString config.maintain-charge.minPercent} ${toString config.maintain-charge.maxPercent}";
          };
          wantedBy = [ "multi-user.target" ];
        };
      };
    };
  };
}
