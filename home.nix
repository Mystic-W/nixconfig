{ config, pkgs, lib, helium, ... }:

{
  home.username = "mystic";
  home.homeDirectory = "/home/mystic";

  # Use the same version as your NixOS system.stateVersion.
  # Do not randomly change this later.
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.libxkbcommon
    pkgs.gcc
    pkgs.gdb
    pkgs.cmake
    pkgs.ninja
    pkgs.clang-tools

    helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  programs.kitty = {
    enable = true;
  };

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
      disable-while-typing = true;
    };

    "org/gnome/desktop/interface" = {
      # dark mode
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
      enable-hot-corners = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Kitty";
      command = "kitty";
      binding = "<Super>t";
    };

    "org/gnome/settings-daemon/plugins/housekeeping" = {
      donation-reminder-enabled = false;
    };

    "org/gnome/desktop/default-applications/terminal" = {
      exec = "kitty";
      exec-arg = "";
    };

  };

  programs.vscode = {
    enable = true;

    package = pkgs.vscode.fhs;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.copilot
	github.copilot-chat

        #c++ extension pack listed explicitly 
	ms-vscode.cpptools
	ms-vscode.cmake-tools
      ];

      userSettings = {
        "github.copilot.enable" = {
	  "*" = true;
	};
      };
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
