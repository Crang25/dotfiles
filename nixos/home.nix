{config, pkgs, ...}: {
  home = {
      username = "violin";
      homeDirectory = "/home/violin";
      stateVersion = "25.05";
  };

  imports = [
   # Path to your nixvim.nix file
   # ./nixvim.nix
  ];
}
