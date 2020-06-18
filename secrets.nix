if builtins.pathExists ./private/secrets.nix then
  import ./private/secrets.nix
else {
  hosts = "";
  keys = "";
  rootKeys = "";
  pia-conf = "";
  vimrc = "";
  github_token = "";
}
