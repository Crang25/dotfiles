{ pkgs }:

pkgs.dwm.override {
  conf = ../../dwm/config.h;
  patches = [
    (pkgs.fetchpatch {
      url = "https://dwm.suckless.org/patches/systray/dwm-systray-20230922-9f88553.diff";
      hash = "sha256-Kh1aP1xgZAREjTy7Xz48YBo3rhrJngspUYwBU2Gyw7k=";
    })
    ../patches/dwm-no-occupied-tag-indicator.patch
  ];
}
