if builtins.pathExists ./private/secrets.nix then import ./private/secrets.nix else {
  hosts = "";
  keys = "";
  pia-conf = "";
  vimrc = "";
  github_token = "";
}
