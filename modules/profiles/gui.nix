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
      (conky.override {
        nvidiaSupport=true;
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
      zathura

      python38 # for conky and to avoid excessivejournalling
      notify-osd-customizable
      libnotify
      xorg.xmessage
    ];

    fonts.enableFontDir = true;
    fonts.fonts = with pkgs; [
      #fantasque-sans-mono # installed imperatively for alpha version
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
        config = ''
          Section "InputClass"
            Identifier "Trackball"
            MatchIsPointer "yes"
            MatchVendor "Kensington"
            Driver "evdev"
            Option "ButtonMapping" "3 8 1 4 5 0 0 2"
          EndSection
        '';

        displayManager.slim = {
          enable = true;
          theme = pkgs.fetchurl {
            url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
            sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
          };
          defaultUser = "john";
          extraConfig = ''
            session_color #000000
          '';
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
        temperature.night = 3000;
      };
    };

  };
}
