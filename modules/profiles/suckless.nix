{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.suckless;
in
{
  options = {
    profiles.suckless = {
      enable = mkOption {
        default = false;
        description = "Enable suckless profile and configuration";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      dwm = pkgs.dwm.override {
        patches = [
          ../../assets/patches/dwm/dwm-custom-6.2.diff
        ];
      };
      dmenu = pkgs.dmenu.override {
        patches = [
          ../../assets/patches/dmenu/dmenu-custom-4.9.diff
        ];
      };
      st = pkgs.st.override {
        patches = [
          ../../assets/patches/st/st-custom-0.8.2.diff
        ];
      };
      surf = pkgs.surf.override {
        patches = [
          ../../assets/patches/surf/surf-custom-2.0.diff
        ];
      };
    };
    home.packages = with pkgs; [
      (slstatus.override { conf = builtins.readFile ../../assets/patches/slstatus/config.def.h; })
      dmenu
      dwm
      st
      surf
      tabbed
    ];
  };
}