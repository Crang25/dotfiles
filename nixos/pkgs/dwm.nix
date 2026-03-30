{ pkgs }:

pkgs.dwm.override {
  conf = ../../dwm/config.h;
  patches = [ ];
}
