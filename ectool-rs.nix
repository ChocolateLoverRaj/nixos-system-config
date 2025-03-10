{ rustPlatform, pkgs, ... }:

rustPlatform.buildRustPackage {
  pname = "ectool-rs";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "FyraLabs";
    repo = "crosec-rs";
    rev = "d7d124b85f7ef211a7d31f36293ed79124264c4c";
    sha256 = "1iga3320mgi7m853la55xip514a3chqsdi1a1rwv25lr9b1p7vd3";
  };

  cargoHash = "sha256-uKXg6k+LHsz2HmhfIlLhEW82n7MUFk4RrN3kdg7nixo=";

  meta = {
    description = "A Rust library and tools for interfacing with the ChromeOS Embedded Controller. ";
    homepage = "https://github.com/FyraLabs/crosec-rs";
  };
}
