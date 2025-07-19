{ pkgs, lib, ... }:

{
  services = {
    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = with pkgs; [
        (stdenv.mkDerivation {
          name = "vevor-cups";
          version = "1.0.2";
          nativeBuildInputs = with pkgs; [
            autoPatchelfHook
          ];
          buildInputs = with pkgs; [
            cups
          ];
          src = fetchurl {
            url = "https://document.vevor.online/software/20221128/Vevor_Driver_Linux.run";
            hash = "sha256-jUzRhIN8O+StcVsCb7La/xCsPWxdhJ0MJALurDRCaSg=";
          };
          unpackPhase = ''
            tail +15 $src > Vevor_Driver_Ubuntu.tar.gz
            tar zxf Vevor_Driver_Ubuntu.tar.gz
          '';
          installPhase = ''
            mkdir -p $out/lib/cups/filter/VevorPrinter/Filter
            cp -rf Vevor_Driver_Ubuntu/VevorPrinter/Filter/rastertolabel $out/lib/cups/filter/VevorPrinter/Filter
            mkdir -p $out/lib/cups/filter/VevorPrinter300/Filter
            cp -rf Vevor_Driver_Ubuntu/VevorPrinter300/Filter/rastertolabel $out/lib/cups/filter/VevorPrinter300/Filter

            mkdir -p $out/share/cups/model
            cp Vevor_Driver_Ubuntu/VevorPrinter/PPDs/Vevor_Label_Printer.ppd $out/share/cups/model
            cp Vevor_Driver_Ubuntu/VevorPrinter300/PPDs/Vevor_Label_Printer300.ppd $out/share/cups/model
          '';

          meta = with lib; {
            description = "CUPS Linux drivers for VEVOR thermal label printers";
            downloadPage = "https://www.vevor.com/pages/download-center-label-printer";
            platforms = platforms.linux;
            maintainers = with maintainers; [ ChocolateLoverRaj ];
            license = licenses.unfree;
          };
        })
        epson-escpr2
        (stdenv.mkDerivation {
          name = "rollo-x1038";
          version = "1.8.4";
          src = fetchTarball {
            url = "https://rollo-main.b-cdn.net/driver-dl/linux/rollo-cups-driver-1.8.4.tar.gz";
            sha256 = "sha256:0x8dd6wj5n974k3vb3iir61dd46ag13zj7s9dhgv722cky7v57h4";
          };
          nativeBuildInputs = [
            cups
          ];
          installPhase = ''
            install -d -m 755 $out/lib/cups/filter
            install -c -m 755 rastertorollo $out/lib/cups/filter
            install -d -m 755 $out/share/cups/model
            install -c -m 644 rollo-x1038.ppd $out/share/cups/model
          '';
          meta = with lib; {
            description = "CUPS Linux drivers for the Rollo X1038 thermal label printer";
            downloadPage = "https://www.rollo.com/driver-linux/";
            platforms = platforms.linux;
            maintainers = with maintainers; [ ChocolateLoverRaj ];
            license = licenses.gpl3;
          };
        })
      ];
      # Share printers - https://nixos.wiki/wiki/Printing#Printer_sharing
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
      extraConf = ''
        DefaultEncryption Never
      '';
    };

    # This is needed to discover printers in the network
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      # Share printers - https://nixos.wiki/wiki/Printing#Printer_sharing
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };
}
