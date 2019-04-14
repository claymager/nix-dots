with import <nixpkgs> {};

let
  plugins = pkgs.callPackage ./plugins.nix {};
  base = builtins.readFile ./base.vim;
  plug = builtins.readFile ./plugins.vim;
  private = builtins.readFile ../private/private.vim;

in
  neovim.override {
    extraPythonPackages = (ps: with ps; [ future ]);
    viAlias = true;
    configure = {
      customRC = ''
        ${base}
        ${plug}
        ${private}
        '';
      vam.knownPlugins = pkgs.vimPlugins // plugins;
      vam.pluginDictionaries = [
        # Universal plugins
        { names = [
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
          "vim-textobj-user"
          "tabular"

          # IDE
          "Syntastic"
          "LanguageClient-neovim"
          "vim-commentary"

          # Code completion
          "ultisnips"
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
          "vimtex"
        ]; }
      ];
    };
  }

