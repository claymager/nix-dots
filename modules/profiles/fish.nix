{ config, pkgs, lib, ... }:

with lib; {
  options.profiles.fish.enable = mkEnableOption "fish profile";

  config = mkMerge [
    (mkIf config.profiles.fish.enable {
      environment = {
        variables = {
          EDITOR = "nvim";
          SYSTEMD_COLORS = "1";
        };
        shellAliases = {
          watch = "watch -c";
        };
      };

      programs.fish = {
        enable = true;
        promptInit = builtins.readFile ./fish/prompt.fish;
        shellInit = builtins.readFile ./fish/init.fish;
        interactiveShellInit = builtins.readFile ./fish/interactive.fish;
        loginShellInit = builtins.readFile ./fish/login.fish;
      };
    })

    (mkIf
      (!builtins.any (p: p == pkgs.kitty) config.environment.systemPackages) {
        environment.variables.TERM = mkDefault "xterm-color";
      })
  ];
}
