{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      libfprint = super.libfprint.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "Xelef2000";
          repo = "libfprint";
          rev = "5bdb3a29a85fd408178339e980cc18fce7fa1875";
          hash = "sha256-Zsd5koxsnI6LqzhGQhtMe/mOVBcclLJPexK193P/mow=";
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
