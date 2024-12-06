{ pkgs, lib, ... }:

{
  # nixpkgs.overlays = [
  #   (final: prev:
  #     {
  #       libfprint = prev.libfprint.overrideAttrs (old: {
  #         version = "1.94.8-crfpmoc";
  #         src = fetchFromGitLab {
  #           domain = "gitlab.freedesktop.org";
  #           owner = "fandango96a";
  #           repo = "libfprint";
  #           rev = "feature/crfpmoc";
  #           hash = null;
  #         };
  #       });
  #     })
  # ];

  system.replaceDependencies.replacements = with pkgs; [
    ({
      original = libfprint;
      replacement = libfprint.overrideAttrs (old: {
        version = "1.94.8";
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "fandango96";
          repo = "libfprint";
          rev = "56dc7f7524dabc0da55f2a15f7706e73778aa5e7";
          hash = "sha256-ySifkClM6qjDlm8iPMwWngHs5PrB1reddreziIUEs5k=";
        };
      });
    })
  ];

  services.fprintd = {
    enable = true;
  };
}
