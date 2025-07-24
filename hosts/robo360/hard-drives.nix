{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
      smartmontools
      ];


  services.scrutiny = {
    enable = true;
    openFirewall = true;
  };
}
