{
  services.caddy = {
    enable = true;

    virtualHosts."git.spcf.me".extraConfig = ''
      reverse_proxy 127.0.0.1:3000
    '';
    virtualHosts."meow.spcf.me".extraConfig = ''
      respond "meow"
    '';
  };
}