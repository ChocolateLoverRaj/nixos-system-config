{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  name = "cros-ectool";
  nativeBuildInputs = with pkgs; [
    cmake
    ninja
    pkg-config
    libusb1
    libftdi1
  ];
  src = pkgs.fetchFromGitLab {
    domain = "gitlab.howett.net";
    owner = "DHowett";
    repo = "ectool";
    rev = "0ac6155abbb7d4622d3bcf2cdf026dde2f80dad7";
    hash = "sha256-EMOliuyWB0xyrYB+E9axZtJawnIVIAM5nx026tESi38=";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp src/ectool $out/bin/ectool
  '';
  meta = with lib; {
    description = "ectool for ChromeOS devices";
    homepage = "https://gitlab.howett.net/DHowett/ectool";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ChocolateLoverRaj ];
    platforms = platforms.linux;
    mainProgram = "ectool";
  };
}
