{pkgs, fetchgit }:

let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {
  "dracula-theme" = buildVimPlugin {
    name = "dracula-theme";
    src = fetchgit {
      url = "https://github.com/dracula/vim/archive/v1.5.0.tar.gz";
      sha256 = "1vnhkfihxg7jqxvwvxidlyfdz5l5lfwbwm0dw73mxiwxwd92ahid";
		};
	};
  "vim-fish" = buildVimPlugin {
    name = "vim-fish";
    src = fetchgit {
      url = "https://github.com/dag/vim-fish";
      rev = "50b95cbbcd09c046121367d49039710e9dc9c15f"; 
      sha256 = "1yvjlm90alc4zsdsppkmsja33wsgm2q6kkn9dxn6xqwnq4jw5s7h";
		};
	};
  "quick-scope" = buildVimPlugin {
    name = "quick-scope";
    src = fetchgit {
      url = "https://github.com/unblevable/quick-scope";
      rev = "10029708ee50d300d4b5e3475610210d4b29c74d";
      sha256 = "1nlrj5n0lzqy267rvza3ky5yf8plad5fpb1r8dqgq5s3k4l448mg";
    };
  };
  "SimpylFold" = buildVimPlugin { 
    name = "SimpylFold";
    src = fetchgit {
      url = "https://github.com/tmhedberg/SimpylFold";
      rev = "aa0371d9d708388f3ba385ccc67a7504586a20d9";
      sha256 = "1fmg2c40x22bxc40a4i7acvf6h1hw0ws39kpkn77p1kfhgiaxqwn";
    };
  };
}
