{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.windows10 = {
      ids = [
        "046d:404b:faa63729"
      ];
      settings = {
        main = {
          capslock = "leftmeta";
          meta = "leftalt";
        };
        alt = {
          backspace = "delete";
          capslock = "capslock";
        };
      };
    };
  };
}
