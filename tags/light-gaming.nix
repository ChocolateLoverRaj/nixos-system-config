# Includes stuff for playing light games
{ pkgs, ... }:

{
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  # environment.systemPackages = with pkgs; [
  #   bindfs
  #   fuse
  # ];

  # programs.fuse.userAllowOther = true;

  # systemd.tmpfiles.rules = [
  #   "d /steam_real 0770 root gamers -"
  #   "d /steam_shared 0770 root gamers -"
  # ];

  # fileSystems."/steam_shared" = {
  #   device = "/steam_real";
  #   fsType = "fuse.bindfs";
  #   options = [
  #     # Dynamically mirror ownership to whoever accesses the folder if they belong to 'gamers'
  #     "mirror-only=@gamers"
  #     # Group mapping and standard permissions inside the mount
  #     "group=gamers"
  #     "perms=0770:+X"
  #     "allow_other"
  #     # Caches file metadata in kernel RAM to minimize FUSE performance impact
  #     "kernel_cache"
  #     "x-systemd.requires=systemd-tmpfiles-setup.service"
  #     "x-systemd.after=systemd-tmpfiles-setup.service"
  #   ];
  # };
}
