# Config settings for a generic development environment 
# (as opposed to iot)

{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      nixops
      (import ./nvim)
      neovim-remote
      # (python3.withPackages(ps: [
      #   ps.python-language-server
      #   ps.pyls-mypy ps.pyls-isort ps.pyls-black
      # ]))
      lm_sensors
      mongodb-tools
      pass
      pciutils
      todo-txt-cli
    ];
  };
}
