{ pkgs, lib, config, ... }:

let
  manage-tv-package = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "manage-tv";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "ChocolateLoverRaj";
      repo = "rust-esp32c3-examples";
      rev = "main";
      hash = "sha256-Si/aWfgyVPSM2SmIYgpBoYfDNoowwCA0hQAsx3KqsGw=";
    };
    sourceRoot = "${src.name}/smart-power-button";
    buildAndTestSubdir = "computer";
    cargoLock = {
      lockFile = ./Cargo.lock;
    };
    nativeBuildInputs = [
      pkg-config
      openssl
      openssl.dev
    ];
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
in
{
  options.manage-tv.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
  config = {
    systemd.services.manage-tv = {
      enable = config.manage-tv.enable;
      description = "Automatically turn on/off the TV and sound system";
      serviceConfig = {
        Type = "exec";
        KillSignal = "SIGINT";
        ExecStart = "${manage-tv-package}/bin/service";
      };
      wantedBy = [ "multi-user.target" ];
    };
    services.logind.extraConfig = "InhibitDelayMaxSec=60";
  };
}
