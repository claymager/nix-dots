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
  "vim-textobj-python" = buildVimPlugin {
    name = "vim-textobj-python";
    src = fetchgit {
      url = "https://github.com/bps/vim-textobj-python";
      rev = "585c76d58f1a9c458c87471b072c9ad9eb159ae2"; 
      sha256 = "1jk0vf5v6l0sf9akgfy6bhfa8rmbvb413aam6zx5nc1ddpzb0ryy";
		};
	};
  "vim-textobj-user" = buildVimPlugin {
    name = "vim-textobj-user";
    src = fetchgit {
      url = "https://github.com/kana/vim-textobj-user";
      rev = "074ce2575543f790290b189860597a3dcac1f79d";
      sha256 = "15wnqkxjjksgn8a7d3lkbf8d97r4w159bajrcf1adpxw8hhli1vc";
		};
	};
  "vim-textobj-indent" = buildVimPlugin {
    name = "vim-textobj-indent";
    src = fetchgit {
      url = "https://github.com/michaeljsmith/vim-indent-object";
      rev = "5c5b24c959478929b54a9e831a8e2e651a465965";
      sha256 = "1kmwnz0jxjkvfzy06r7r73pcxfcyjp8p8m2d6qrhjfvzidgfhw19";
		};
	};
}
