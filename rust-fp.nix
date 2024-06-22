{ lib, pkgs, ... }:

let
  rust-fp = pkgs.fetchFromGitHub {
    owner = "ChocolateLoverRaj";
    repo = "cros-fp-pam";
    rev = "b38c1b93a0f1015629a7c8f77bea77ef7e9ac76a";
    hash = "sha256-NLK2ImU7Bn6hjMFwchCDp79+QumvLwWUMp48xXjU0bE=";
  };
  rust-fp-dbus-interface-config = (pkgs.stdenv.mkDerivation rec {
    name = "rust-fp-pam";
    src = "${rust-fp}/dbus-interface";
    installPhase = ''
      mkdir -p $out/share/dbus-1/system.d
      cp $src/org.rust_fp.RustFp.conf $out/share/dbus-1/system.d
      echo Cros FP Pam output at $out
    '';
  });
  rust-fp-dbus-interface = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "rust-fp-dbus-interface";
    version = "1.0.0";
    cargoLock = {
      lockFile = ./rust-fp-Cargo.lock;
      outputHashes = {
        "crosec-0.1.0" = "sha256-q6RzJ3dtbLC82O3j1V+0d3krFGwDWHm1eBPZdATpMZ4=";
      };
    };
    src = rust-fp;
    buildAndTestSubdir = "dbus-interface";
    nativeBuildInputs = [
      rustPlatform.bindgenHook
      rustPlatform.cargoBuildHook
    ];
  };
  rust-fp-cli = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "rust-fp-cli";
    version = "1.0.0";
    cargoLock = {
      lockFile = ./rust-fp-Cargo.lock;
      outputHashes = {
        "crosec-0.1.0" = "sha256-q6RzJ3dtbLC82O3j1V+0d3krFGwDWHm1eBPZdATpMZ4=";
      };
    };
    src = rust-fp;
    buildAndTestSubdir = "cli";
    nativeBuildInputs = [
      rustPlatform.bindgenHook
      rustPlatform.cargoBuildHook
    ];
  };
  rust-fp-pam-module = with pkgs; rustPlatform.buildRustPackage rec {
    pname = "rust-fp-pam-module";
    version = "1.0.0";
    cargoLock = {
      lockFile = ./rust-fp-Cargo.lock;
      outputHashes = {
        "crosec-0.1.0" = "sha256-q6RzJ3dtbLC82O3j1V+0d3krFGwDWHm1eBPZdATpMZ4=";
      };
    };
    src = rust-fp;
    buildAndTestSubdir = "pam-module";
    nativeBuildInputs = [
      rustPlatform.bindgenHook
      rustPlatform.cargoBuildHook
    ];
    buildInputs = [
      pam
    ];
  };
in
{
  systemd.services.rust-fp-dbus-interface = {
    enable = true;
    description = "Gives normal user access to enrolling and matching fingerprints";
    serviceConfig = {
      Type = "exec";
      ExecStart = "${rust-fp-dbus-interface}/bin/rust-fp-dbus-interface";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Example: https://github.com/NixOS/nixpkgs/issues/239770#issuecomment-1608589113
  security.pam.services.kde-fingerprint.text = ''
    auth    sufficient    ${rust-fp-pam-module}/lib/librust_fp_pam_module.so
    account sufficient    ${rust-fp-pam-module}/lib/librust_fp_pam_module.so
  '';

  environment.systemPackages = [
    rust-fp-dbus-interface-config
    rust-fp-cli
  ];
}
