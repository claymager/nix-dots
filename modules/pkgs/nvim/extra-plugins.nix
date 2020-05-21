{pkgs, fetchgit }:

let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {
  "dracula-theme" = buildVimPlugin {
    name = "dracula-theme";
    src = fetchgit {
      url= "https://github.com/dracula/vim";
      rev= "9b856347b905dc616baf02b48d7631bc3084726e";
      sha256= "0w9aj42hb8x7601gbgf0ggs7p3sm5wrv23bnvrjgdlf3mapg6dwy";
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

  "vim-textobj-line" = buildVimPlugin {
    name = "vim-textobj-line";
    src = fetchgit {
      url = "https://github.com/kana/vim-textobj-line";
      sha256 = "93a9239b036a9a49556828a033304bef1a6e3007b3a93d86dd970fb42a7bf756";
		};
  };

  "deoplete" = buildVimPlugin {
    name = "deoplete";
    src = fetchgit {
      url = "https://github.com/Shougo/deoplete.nvim";
      rev = "5c50f254175ee1e815a47761c50abec861afcc61";
      sha256 = "133zlaha0lvibrcd4ci7h353pgv64yyvvh211g8pdlq8vd9qbrhn";
		};
	};

  "vim-hug-neovim-rpc" = buildVimPlugin {
    name = "vim-hug-neovim-rpc";
    src = fetchgit {
      url = "https://github.com/roxma/vim-hug-neovim-rpc";
      rev = "55db7affbc9527464a88fb2d5f133f4994415f10";
      sha256 = "1zlr761q12ds9z7xazrjfzqzrxd3z1dcxfq0p0vghwngrx8yqgyx";
		};
	};


  "vim-syntax-shakespeare" = buildVimPlugin {
    name = "vim-syntax-shakespeare";
    src = fetchgit {
      url = "https://github.com/pbrisbin/vim-syntax-shakespeare";
      rev = "2f4f61eae55b8f1319ce3a086baf9b5ab57743f3";
      sha256 = "0h79c3shzf08g7mckc7438vhfmxvzz2amzias92g5yn1xcj9gl5i";
		};
	};
}
