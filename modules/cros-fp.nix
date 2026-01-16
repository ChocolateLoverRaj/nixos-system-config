{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      libfprint = super.libfprint.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "Xelef2000";
          repo = "libfprint";
          rev = "fde6d376a1d55a0a74749abf0d291ca7cabee9ad";
          hash = "sha256-SZs90Gso/AFrQsea4bPnqfFmBF0UqcgvNtqoKfU4gnI=";
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
