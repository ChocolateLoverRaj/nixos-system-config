{ ... }:

{
  # This resulted in a kernel panic last time I tried (Feb 23 2025)
  boot.kernelParams = [ "loglevel=15" "console=ttyS0,115200n8" ];
}
