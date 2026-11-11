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
          pname = "munbyn-itpp941-cups";
          version = "1.0.0";

          src = fetchurl {
            url = "https://filedn.com/lN6To1twXYMYeSDMQm2JQWV/ITPP941/01-Driver/Munbyn_Driver_Ubuntu_Install.run";
            hash = "sha256-qibdUgT0VOWnW7bMSriI89hrRYigjL+jTgr+2vp/6j0=";
          };

          nativeBuildInputs = [ autoPatchelfHook ];

          buildInputs = [ cups ];

          unpackPhase = ''
            runHook preUnpack

            tail +9 $src > src.tar.gz
            tar zxf src.tar.gz

            runHook postUnpack
          '';

          installPhase = ''
            runHook preInstall

            mkdir -p $out/lib/cups/filter/Munbyn/Filter
            cp -rf Munbyn_Driver_Ubuntu/Munbyn/Filter/rastertolabel $out/lib/cups/filter/Munbyn/Filter

            mkdir -p $out/share/cups/model
            cp Munbyn_Driver_Ubuntu/Munbyn/PPDs/Munbyn_Label_Printer.ppd $out/share/cups/model

            runHook postInstall
          '';

          meta = with lib; {
            description = "CUPS Linux drivers for MUNBYN ITPP941 Label Printer (203 DPI version)";
            downloadPage = "https://munbyn.com/products/thermal-shipping-label-printer";
            platforms = platforms.linux;
            maintainers = with maintainers; [ ChocolateLoverRaj ];
            license = licenses.unfree;
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
      settings = {
        publish = {
          disable-publishing = false;
          disable-user-service-publishing = false;
          publish-addresses = true;
        };
      };
    };
  };
}
