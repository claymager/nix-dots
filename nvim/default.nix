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
            "SimpylFold"
            "Syntastic"
            "ctrlp"
            "dracula-theme"
            "elm-vim"
            "flake8-vim"
            "fugitive"
            "nerdcommenter"
            "nerdtree"
            "quick-scope"
            "rhubarb"
            "tabular"
            "ultisnips"
            "vim-airline"
            "vim-airline-themes"
            "vim-fish"
            "vim-nix"
            "vim-pandoc"
            "vim-pandoc-syntax"
            "vim-snippets"
            "youcompleteme"
          ];
        }
      ];
    };
  }

