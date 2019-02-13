# Edit this configuration file to define what should be installed on
# all systems.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;

  networking.extraHosts = ''
    192.168.1.16  frey
    192.168.1.29  wyvern
    '';

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Detroit";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = let
    guiPackages =
      if config.services.xserver.enable then
        with pkgs; [
          qutebrowser
          google-chrome
          slack
          termite
          feh
          scrot
          spotify
          playerctl
          pavucontrol
        ]
      else
        [ ];
    in with pkgs; [
      tree
      pavucontrol
      wget
      htop
      mongodb-tools
      lm_sensors
      neovim
      w3m
      git
      alsaUtils
      pass
      xclip
      gnupg

      pciutils
      file

      #cudatoolkit
    ] ++ guiPackages;

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    fantasque-sans-mono
    corefonts
    terminus_font
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.bash.enableCompletion = true;
  #programs.mtr.enable = true;
  #programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 5900 5901 5902 5903];
  #networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;
  #networking.networkmanager.enable = true;

  environment.shellAliases = {
    l = "ls -XlhGgo --color=auto";
    t = "tree --filelimit 30 -CL 3";
    mv = "mv -i";
    rm = "rm -I";
    vi = "nvim";
    to = "todo.sh";
    neo = "nvim";
    view = "nvim -R";
  };

  programs.fish = {
    enable = true;
    promptInit = ''
      set normal (set_color normal)
      set magenta (set_color magenta)
      set yellow (set_color yellow)
      set green (set_color green)
      set red (set_color red)
      set gray (set_color -o black)

      # Fish git prompt
      set __fish_git_prompt_showdirtystate 'yes'
      set __fish_git_prompt_showstashstate 'yes'
      set __fish_git_prompt_showuntrackedfiles 'yes'
      set __fish_git_prompt_showupstream 'yes'
      set __fish_git_prompt_color_branch yellow
      set __fish_git_prompt_color_upstream_ahead green
      set __fish_git_prompt_color_upstream_behind red

      # Status Chars
      set __fish_git_prompt_char_dirtystate 'M'
      set __fish_git_prompt_char_stagedstate '→'
      set __fish_git_prompt_char_untrackedfiles '?'
      set __fish_git_prompt_char_stashstate '«'
      set __fish_git_prompt_char_upstream_ahead '+'
      set __fish_git_prompt_char_upstream_behind '-'

      function fish_prompt

        set last_status $status

        set_color $fish_color_cwd
        printf '%s' (prompt_pwd)
        set_color normal

        printf '%s ' (__fish_git_prompt)

        if test -n "$IN_NIX_SHELL"
          set_color 0ff
          printf "❄ "
        end

        set_color normal
      end
    '';

    shellInit = ''
      function haskellEnv
        nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
      end

      function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
        if set -q argv[2]
          set argv $argv[2..-1]
        end
        for el in $argv
          set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end
        nix-shell -p $ppkgs
      end

      set fish_greeting ""

      '';
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    resizeAmount = 20;
    shortcut = "d";
    extraTmuxConf = ''
    set -sg escape-time 10
    '';
  };

  services = {
    xserver = {
      # keyboard
      layout = "us";
      xkbVariant = "altgr-intl";
      xkbOptions = "nodeadkeys";

      # window manager
      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
        default = "xmonad";
      };

      displayManager.slim = {
        enable = true;
        theme = pkgs.fetchurl {
          url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
          sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
        };
        defaultUser = "john";
      };

      desktopManager.xterm.enable = false;
    };

    unclutter.enable = true;
    redshift = {
      enable = true;
      latitude = "41.881";
      longitude = "-87.623";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.john = {
    isNormalUser = true;
    home = "/home/john";
    extraGroups = [ "wheel" "networkmanager" "audio" "docker"];
    shell = "/run/current-system/sw/bin/fish";
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
