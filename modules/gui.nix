# Configs I like in a gui environment

{ config, pkgs, ... }:

{

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };


  environment.systemPackages = with pkgs; [
    (conky.override {
      nvidiaSupport=true;
      pulseSupport=true;
    })
    alsaUtils
    discord
    feh
    google-chrome
    kitty
    pavucontrol
    playerctl
    qutebrowser
    scrot
    slack
    spotify
    vlc
    xclip

    notify-osd-customizable
    libnotify
    xorg.xmessage
  ];


  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    #fantasque-sans-mono # installed imperatively for alpha version
    fira-code
    corefonts
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

      displayManager.slim = {
        enable = true;
        theme = pkgs.fetchurl {
          url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
          sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
        };
        defaultUser = "john";
      };

      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
        default = "xmonad";
      };
    };

    unclutter.enable = true;
    redshift = {
      enable = true;
      latitude = "41.881";
      longitude = "-87.623";
      temperature.night = 3000;
    };
  };

}
