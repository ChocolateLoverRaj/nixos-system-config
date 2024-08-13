{ pkgs, ... }:

let
  manage-tv = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "manage-tv";
    version = "1.0.0";
    # src = /home/rajas/Documents/rust-esp32c3-examples/smart-power-button;
    src = fetchFromGitHub {
      owner = "ChocolateLoverRaj";
      repo = "rust-esp32c3-examples";
      rev = "main";
      hash = "sha256-ztyWDUbaLGN2zmThkJIFtTKGfKXPLOiCXrwv72VgQyg=";
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
  systemd.services.manage-tv = {
    enable = true;
    description = "Automatically turn on/off the TV and sound system";
    serviceConfig = {
      Type = "exec";
      KillSignal = "SIGINT";
      ExecStart = "${manage-tv}/bin/service";
    };
    wantedBy = [ "multi-user.target" ];
  };
  services.logind.extraConfig = "InhibitDelayMaxSec=60";
}
