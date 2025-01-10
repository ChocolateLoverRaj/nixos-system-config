{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      libfprint = super.libfprint.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "Xelef2000";
          repo = "libfprint";
          rev = "779e82b1e4298996edc1d0eab6b5b97b92494e2f";
          hash = "sha256-KudADZ5zdtyBsfar8FeFRDSuR0ztLbhEWy9pCV4MkWE=";
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
