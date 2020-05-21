with import <nixpkgs> {};

let
  cfg = config.profiles.neovim;

  extraPlugins = pkgs.callPackage ./nvim/extra-plugins.nix {};

  genericPlugins = { names = [
    # Style
    "dracula-theme"
    "vim-airline"
    "vim-airline-themes"

    # File navigation
    "ctrlp"
    "nerdtree"
    "fugitive"
    "rhubarb"
    "vim-gitgutter"

    # Text navigation
    "quick-scope"
    "vim-surround"
    "vim-textobj-indent"
    "vim-textobj-line"
    "vim-textobj-user"
    "tabular"

    # IDE
    "Syntastic"
    "LanguageClient-neovim"
    "vim-commentary"

    # Code completion
    "ultisnips"
    # "vim-skeleton"
    "vim-snippets"
    "deoplete"
    "nvim-yarp"
    "vim-hug-neovim-rpc"

    # Filetypes
    "SimpylFold"
    "elm-vim"
    "vim-fish"
    "vim-nix"
    "vim-pandoc"
    "vim-pandoc-syntax"
    "vim-textobj-python"
    "vim-syntax-shakespeare"
    "vimtex"
  ]; };

in
pkgs.neovim.override {
  extraPythonPackages = (ps: with ps; [ future ]);
  viAlias = true;
  configure = {
    customRC = with builtins; ''
      ${readFile ./nvim/base.vim}
      ${readFile ./nvim/plugins.vim}
      ${(import ./../../secrets.nix).vimrc}
    '';

    vam.knownPlugins = pkgs.vimPlugins // extraPlugins;
    vam.pluginDictionaries = [ genericPlugins ];
  };
}

