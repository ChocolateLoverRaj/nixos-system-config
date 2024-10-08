{ pkgs, config, lib, ... }:

let
  ectool = (pkgs.callPackage ./cros-ectool.nix { });
  scheduled-charge = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "scheduled-charge";
    version = "1.0.0";
    cargoHash = "sha256-TUZVCKG0+i7tUngoG2Rrx6n2QtDWlcJ0PKoOa2At6h8=";
    src = fetchFromGitHub {
      owner = "ChocolateLoverRaj";
      repo = "cros-ec-battery";
      rev = "0ccc6ebaa2f7541e7e1009130d1c0aba73c3a7fc";
      hash = "sha256-JsJjOIm7jstqGMl3OOfdv69UV7OrsxLcEwiG6Ymm2aM=";
      fetchSubmodules = true;
    };
    sourceRoot = "${src.name}/scheduled-charge";
  };
  auto-stop-charging = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "auto-stop-charging";
    version = "1.0.0";
    cargoHash = "sha256-VDMjhVX1S/UqiMyfGHT8R06V7h4SJchqBRi2JYKfaCk=";
    src = fetchFromGitHub {
      owner = "ChocolateLoverRaj";
      repo = "cros-ec-battery";
      rev = "3c6f320cee42150808387aca37679596a1c7a7e1";
      hash = "sha256-Gv7uHf4dknYw+7tUp5JdHKUlmRDixWC49dp3y/dTwIc=";
    };
    sourceRoot = "${src.name}/auto-stop-charging";
    buildInputs = [ ectool ];
  };
in
{
  options.auto-stop-charging = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    chargeTo = lib.mkOption {
      type = lib.types.float;
      default = 0.8;
    };
    maxChargeSpeed = lib.mkOption {
      type = lib.types.float;
      default = 0.5;
    };
  };

  config = {
    services.logind.extraConfig = "InhibitDelayMaxSec=14400"; # 4 hours
    systemd = {
      timers = {
        charge = {
          enable = config.auto-stop-charging.enable;
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "*-*-* 6:00";
            Unit = "charge.service";
            WakeSystem = true;
            Persistent = true;
          };
        };
      };

      services = {
        charge = {
          unitConfig = {
            ConditionACPower = true;
          };
          serviceConfig = {
            Type = "oneshot";
            ExecStart = with lib.strings; "${scheduled-charge}/bin/scheduled-charge --charge-to ${floatToString config.auto-stop-charging.chargeTo} --max-charge-speed ${floatToString config.auto-stop-charging.maxChargeSpeed}";
          };
        };

        # This should only be needed when manually enabling charging. The charge timer + script will stop charging once it reaches the threshold.
        auto-stop-charging = {
          enable = true;
          description = "Stop charging when the battery reaches the threshold";
          serviceConfig = {
            Type = "exec";
            ExecStart = "${auto-stop-charging}/bin/auto-stop-charging";
          };
          wantedBy = [ "multi-user.target" ];
          path = [ ectool ];
        };
      };
    };
  };
}
