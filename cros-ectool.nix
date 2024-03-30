{ stdenv, pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "cros-ectool";
  nativeBuildInputs = with pkgs; [ cmake ninja pkg-config libusb libftdi1 ];
  src = pkgs.fetchFromGitLab {
    domain = "gitlab.howett.net";
    owner = "DHowett";
    repo = "ectool";
    rev = "3ebe7b8b713b2ebfe2ce92d48fd8d044276b2879";
    hash = "sha256-s6PrFPAL+XJAENqLw5oJqFmAf11tHOJ8h3F5l3pOlZ4=";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp src/ectool $out/bin/ectool
  '';
}
