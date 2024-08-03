{ lib, ... }:

{
  networking = {
    networkmanager.enable = true;
    nameservers = [
      # Cloudflare
      "1.1.1.1"
      "1.0.0.1"
      # Google
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}
