{ pkgs, ... }:

let
  ectool = (pkgs.callPackage ./cros-ectool.nix { });
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
  environment.systemPackages = with pkgs; [
    auto-stop-charging
    ectool
  ];
  systemd.services.auto-stop-charging = {
    enable = true;
    description = "Stop charging when the battery reaches the threshold";
    serviceConfig = {
      Type = "exec";
      ExecStart = "${auto-stop-charging}/bin/auto-stop-charging";
    };
    wantedBy = [ "multi-user.target" ];
    path = [ ectool ];
  };
  powerManagement.powerDownCommands = ''
    ${ectool}/bin/ectool chargecontrol idle
  '';
}
