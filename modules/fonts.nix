{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
    proggyfonts
    cozette
    luculent
  ];
  # home-manager.users.may = { pkgs, ... }: {
  #   fonts.fontconfig.enable = true;

  #   home.packages = with pkgs; [
  #     noto-fonts
  #     noto-fonts-cjk-sans
  #     noto-fonts-color-emoji
  #     liberation_ttf
  #     fira-code
  #     fira-code-symbols
  #     mplus-outline-fonts.githubRelease
  #     dina-font
  #     font-awesome
  #     powerline-fonts
  #     powerline-symbols
  #     nerd-fonts.symbols-only
  #     proggyfonts
  #     cozette
  #     luculent
  #   ];
  # };
}
