{ lib, ...}: {
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_GB.UTF-8/UTF-8";

  services.xserver.xkb = lib.mkDefault {
    layout = "us";
    variant = "";
  };
}
