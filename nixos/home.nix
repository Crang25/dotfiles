{config, pkgs, ...}: {
  home = {
      username = "violin";
      homeDirectory = "/home/violin";
      stateVersion = "25.05";
  };

  home.file.".config/dwm".source = ../dwm;
  home.file.".config/sxhkd/sxhkdrc.dwm".source = ../sxhkd/sxhkdrc.dwm;

  imports = [
   # Path to your nixvim.nix file
   # ./nixvim.nix
  ];
}
