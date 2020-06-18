# Config settings for a generic development environment

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.dev;

  pythonPackage = pkgs.python3.withPackages
    (ps: with ps; [ python-language-server pyls-mypy pyls-isort pyls-black ]);

  haskellPackages = let
    all-hies = import
      (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") { };
  in [
    (all-hies.selection { selector = p: { inherit (p) ghc864; }; })
    pkgs.ghc
  ];

in {
  options.profiles.dev = {
    enable = mkEnableOption "development environment";
    python = mkEnableOption "python ide env";
    haskell = mkEnableOption "haskell ide env";
    tex = mkEnableOption "latex ide env";
  };

  config = mkIf cfg.enable {
    services.dropbox.enable = true;

    environment.systemPackages = with pkgs;
      [
        nixops
        (import ../pkgs/nvim.nix)
        neovim-remote
        mongodb-tools
        pass
        pciutils
        todo-txt-cli
        sqlite-interactive
      ] ++ optional cfg.python pythonPackage
      ++ optionals cfg.haskell haskellPackages
      ++ optional cfg.tex pkgs.texlive.combined.scheme-full;

  };
}
