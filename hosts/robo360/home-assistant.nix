{ ... }:

{
    services.home-assistant = {
        enable = false;
        extraComponents = [
        # Components required to complete the onboarding
        "esphome"
        "met"
        "radio_browser"
        "matter"
        ];
        config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = {};
        };
        openFirewall = true;
    };
}
