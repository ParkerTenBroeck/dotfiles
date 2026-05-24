{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["may"];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}