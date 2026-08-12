{ lib, ...}: {
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  i18n.extraLocales = [
    "en_CA.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    # LC_ALL = "en_CA.UTF-8"; # This overrides all other LC_* settings.
    LC_CTYPE = "en_CA.UTF8";
    LC_ADDRESS = "en_CA.UTF-8";
    LC_MEASUREMENT = "en_CA.UTF-8";
    LC_MESSAGES = "en_CA.UTF-8";
    LC_MONETARY = "en_CA.UTF-8";
    LC_NAME = "en_CA.UTF-8";
    LC_NUMERIC = "en_CA.UTF-8";
    LC_PAPER = "en_CA.UTF-8";
    LC_TELEPHONE = "en_CA.UTF-8";
    LC_TIME = "en_GB.UTF-8";
    LC_COLLATE = "en_CA.UTF-8";
  };

  i18n.supportedLocales = [
    "all"
    "en_CA.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  services.xserver.xkb = lib.mkDefault {
    layout = "us";
    variant = "";
  };
}
