# ./sh.nix (AKA - shell.nix)

{ config, pkgs, ... }:

  let
    myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
    };
  in
  {
    programs.bash = {
      enable = true;
      shellAliases = myAliases;
    };

    programs.zsh = {
      enable = true;
      shellAliases = myAlis=ases;
    };

/*
  # Import this module into home manager:
  imports = [
    ./modules/sh.nix]
  ];
*/

}
