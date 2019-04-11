with import <nixpkgs> {};

let
  plugins = pkgs.callPackage ./plugins.nix {};
  base = builtins.readFile ./base.vim;
  private = builtins.readFile ./private.vim;

in
  neovim.override {
    extraPythonPackages = (ps: with ps; [ future ]);
    viAlias = true;
    configure = {
      customRC = ''
        ${base}
        ${private}
        '';
      vam.knownPlugins = pkgs.vimPlugins // plugins;
      vam.pluginDictionaries = [
        { names = [
            "LanguageClient-neovim"
            "Rename"
            "SimpylFold"
            "Syntastic"
            "ctrlp"
            "dracula-theme"
            "elm-vim"
            "flake8-vim"
            "fugitive"
            "nerdtree"
            "quick-scope"
            "rhubarb"
            "tabular"
            "ultisnips"
            "vim-airline"
            "vim-airline-themes"
            "vim-commentary"
            "vim-fish"
            "vim-nix"
            "vim-pandoc"
            "vim-pandoc-syntax"
            "vim-snippets"
            "vim-surround"
            "vim-textobj-user"
            "vim-textobj-indent"
            "vim-textobj-python"
            "vimtex"
            "youcompleteme"
          ];
        }
      ];
    };
  }

