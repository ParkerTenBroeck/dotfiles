{ lib, pkgs, config, ... }: let 
  domain = "git.spcf.me";
in{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = domain;
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "https://${domain}/"; 
        HTTP_PORT = 3000;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = true; 
      server.SSH_PORT = lib.head config.services.openssh.ports;
    };
  };
}