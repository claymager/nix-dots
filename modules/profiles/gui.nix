# Configs I like in a gui environment

{ config, pkgs, lib, ... }:

with lib;

{
  options.profiles.gui.enable = mkEnableOption "gui environment";

  config = mkIf config.profiles.gui.enable {

    hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    environment.systemPackages = with pkgs; [
      (conky.override { nvidiaSupport = true; })
      alsaUtils
      feh
      google-chrome
      pavucontrol
      playerctl
      scrot
      spotify
      vlc
      xclip
      discord

      (python38.withPackages (ps: with ps; [ evdev ipython ]))
      notify-osd-customizable
      libnotify
      xorg.xmessage
      xorg.xmodmap
    ];

    fonts.enableFontDir = true;
    fonts.fonts = with pkgs; [
      #fantasque-sans-mono
      fira-code
      corefonts
      noto-fonts-cjk
      terminus_font
      font-awesome_5
      hasklig
    ];

    services = {
      xserver = {
        enable = true;
        layout = "us";
        xkbVariant = "altgr-intl";
        desktopManager.xterm.enable = false;
        exportConfiguration = true;
        config = ''
          Section "InputClass"
            Identifier "Trackball"
            MatchIsPointer "yes"
            MatchVendor "Kensington"
            Driver "evdev"
            Option "ButtonMapping" "3 8 1 4 5 0 0 2"
          EndSection
        '';

        displayManager.defaultSession = "none+xmonad";

        windowManager = {
          xmonad.enable = true;
          xmonad.enableContribAndExtras = true;
          # default = "xmonad";
        };
      };

      unclutter.enable = true;
      redshift = {
        enable = true;
        temperature.night = 3000;
      };

    };

  };
}
