{ pkgs, lib, ... }:

{
  boot.kernelPackages = lib.mkDefault pkgs.pkgs.linuxPackages_latest;
  specialisation = {
    "cros_ec-charge-control" = {
      configuration = {
        boot.kernelPackages =
          let
            customName = "cros_ec-charge-control";
            linuxCustomPackage = { fetchurl, buildLinux, ... } @ args:
              buildLinux (args // rec {
                version = "6.9.0-${customName}";
                modDirVersion = version;
                src = pkgs.fetchFromSourcehut {
                  owner = "~t-8ch";
                  repo = "linux";
                  rev = "40cbe62495e3ea14944fa168e3bf77d070c74119";
                  hash = "sha256-yFcGNi57BsHMlmoXBdvijXr6piaWKvippkcC3ZvY97M=";
                };
                kernelPatches = [{
                  name = "fix";
                  patch = null;
                  extraConfig = ''
                    LOCALVERSION -${customName}
                  '';
                  extraStructuredConfig = with lib.kernel; {
                    DRM_DP_AUX_CHARDEV = lib.mkForce unset;
                    DRM_DP_CEC = lib.mkForce unset;
                  };
                }];
                extraMeta.branch = "6.9";
              } // (args.argsOverride or { }));
            linuxCustom = pkgs.callPackage linuxCustomPackage { };
          in
          pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linuxCustom);
      };
    };
    "cros_ec-led" = {
      configuration = {
        boot.kernelPackages =
          let
            customName = "cros_ec-led";
            linuxCustomPackage = { fetchurl, buildLinux, ... } @ args:
              buildLinux (args // rec {
                version = "6.9.0-${customName}";
                modDirVersion = version;
                src = pkgs.fetchFromSourcehut {
                  owner = "~t-8ch";
                  repo = "linux";
                  rev = "74e9d307faadc5125c925593c8391e883b5fd39d";
                  hash = "sha256-LrrnkXhCPJzk/jhygIa0QQkjzdIesu0mtuvSeWRo6o0=";
                };
                kernelPatches = [{
                  name = "fix";
                  patch = null;
                  extraConfig = ''
                    LOCALVERSION -${customName}
                  '';
                  extraStructuredConfig = with lib.kernel; {
                    DRM_DP_AUX_CHARDEV = lib.mkForce unset;
                    DRM_DP_CEC = lib.mkForce unset;
                  };
                }];
                extraMeta.branch = "6.9";
              } // (args.argsOverride or { }));
            linuxCustom = pkgs.callPackage linuxCustomPackage { };
          in
          pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linuxCustom);
      };
    };
    "cros_ec-hwmon" = {
      configuration = {
        boot.kernelPackages =
          let
            customName = "cros_ec-hwmon";
            linuxCustomPackage = { fetchurl, buildLinux, ... } @ args:
              buildLinux (args // rec {
                version = "6.9.0-rc4-${customName}";
                modDirVersion = version;
                src = pkgs.fetchFromSourcehut {
                  owner = "~t-8ch";
                  repo = "linux";
                  rev = "02ffa045d74605e690f0c1205f11fe4f50893e88";
                  hash = "sha256-8MWMgE6AxQ30FVfvOJJDVwAW/N5RrHWzJ6e4MIUCINI=";
                };
                kernelPatches = [{
                  name = "fix";
                  patch = null;
                  extraConfig = ''
                    LOCALVERSION -${customName}
                  '';
                  extraStructuredConfig = with lib.kernel; {
                    DRM_DP_AUX_CHARDEV = lib.mkForce unset;
                    DRM_DP_CEC = lib.mkForce unset;
                  };
                }];
                extraMeta.branch = "6.9";
              } // (args.argsOverride or { }));
            linuxCustom = pkgs.callPackage linuxCustomPackage { };
          in
          pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linuxCustom);
      };
    };
    "cros_ec-kbd-led-framework" = {
      configuration = {
        boot.kernelPackages =
          let
            customName = "cros_ec-kbd-led-framework";
            linuxCustomPackage = { fetchurl, buildLinux, ... } @ args:
              buildLinux (args // rec {
                version = "6.9.0-${customName}";
                modDirVersion = version;
                src = pkgs.fetchFromSourcehut {
                  owner = "~t-8ch";
                  repo = "linux";
                  rev = "1a41ba72b470ce7d277bc42a59d58ebca98398dd";
                  hash = "sha256-h11b+fJH0YBajNxuviAO/TLzssRkOnSYdw8hge9r/Xs=";
                };
                kernelPatches = [{
                  name = "fix";
                  patch = null;
                  extraConfig = ''
                    LOCALVERSION -${customName}
                  '';
                  extraStructuredConfig = with lib.kernel; {
                    DRM_DP_AUX_CHARDEV = lib.mkForce unset;
                    DRM_DP_CEC = lib.mkForce unset;
                  };
                }];
                extraMeta.branch = "6.9";
              } // (args.argsOverride or { }));
            linuxCustom = pkgs.callPackage linuxCustomPackage { };
          in
          pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linuxCustom);
      };
    };
    "20240505-cros_ec-kbd-led-framework-7e2e831bc79c-v2" = {
      configuration = {
        boot.kernelPackages =
          let
            customName = "20240505-cros_ec-kbd-led-framework-7e2e831bc79c-v2";
            linuxCustomPackage = { fetchurl, buildLinux, ... } @ args:
              buildLinux (args // rec {
                version = "6.9.0-rc4-${customName}";
                modDirVersion = version;
                src = pkgs.fetchFromSourcehut {
                  owner = "~t-8ch";
                  repo = "linux";
                  rev = "9a67a159178a8a930e37f2daf9166df55aea15c6";
                  hash = "sha256-jxaUbxkzZKlEcFZYG/CuPAOwrOEX8L1yQ2a5lV+CmKQ=";
                };
                kernelPatches = [{
                  name = "fix";
                  patch = null;
                  extraConfig = ''
                    LOCALVERSION -${customName}
                  '';
                  extraStructuredConfig = with lib.kernel; {
                    DRM_DP_AUX_CHARDEV = lib.mkForce unset;
                    DRM_DP_CEC = lib.mkForce unset;
                  };
                }];
                extraMeta.branch = "6.9";
              } // (args.argsOverride or { }));
            linuxCustom = pkgs.callPackage linuxCustomPackage { };
          in
          pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linuxCustom);
      };
    };
  };
}
