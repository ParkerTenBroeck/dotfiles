{ lib, ...}: {
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.xkb = lib.mkDefault {
    layout = "us";
    variant = "";
  };
}
