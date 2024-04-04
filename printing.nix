{ ... }:

{
  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    # This is needed to discover printers in the network
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
