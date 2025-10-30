{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      libfprint = super.libfprint.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "Xelef2000";
          repo = "libfprint";
          rev = "5c411c6f1f72830b7fc5f99662db5aeb99caefe5";
          hash = "sha256-NR1te/WP3xJcJ9ggC8PdBcMptqut5Hl8C6/6TccCTEI=";
        };
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    fprintd
  ];

  services.fprintd = {
    enable = true;
  };
}
