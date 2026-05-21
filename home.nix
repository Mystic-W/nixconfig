{ config, pkgs, lib, helium, ... }:

{
  home.username = "mystic";
  home.homeDirectory = "/home/mystic";

  # Use the same version as your NixOS system.stateVersion.
  # Do not randomly change this later.
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.libxkbcommon
    helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "caps:unlock_on_press"
      ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      show-desktop = [ "<Super>d" ];
    };
    
    "org/gnome/desktop/peripherals/mouse" = {
      # "flat" = no adaptive mouse acceleration
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      # bottom/right touchpad area acts as right click
      click-method = "areas";
    };

    "org/gnome/desktop/interface" = {
      # dark mode
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };
  };

  home.file.".config/xkb/compat/caps_win".text = ''
    partial xkb_compatibility "unlock_on_press" {
      interpret Caps_Lock+AnyOfOrNone(all) {
        action= LockMods(modifiers=Lock, unlockOnPress=true);
      };
    };
   '';

  home.file.".config/xkb/rules/evdev".text = ''
    ! include %S/evdev

    ! option = compat
      caps:unlock_on_press = +caps_win(unlock_on_press)
  '';

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "helium.desktop";
      "text/xml" = "helium.desktop";
      "application/xhtml+xml" = "helium.desktop";
      "x-scheme-handler/http" = "helium.desktop";
      "x-scheme-handler/https" = "helium.desktop";
      };
  };
}
