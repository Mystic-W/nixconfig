{ config, pkgs, lib, helium, ... }:

{
  
  imports = [
    ./home-modules/hyprland.nix
    ./home-modules/waybar.nix
    ./home-modules/rofi.nix
    ./home-modules/hyprpaper.nix
  ];

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

  services.gnome-keyring.enable = true;

  programs.kitty = {
    enable = true;
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
	      ms-vsliveshare.vsliveshare
        
        mshr-h.veriloghdl
      ];

      userSettings = {
        "github.copilot.enable" = {
	  "*" = true;
	};
      };
    };
  };
  
  home.file.".vscode/argv.json" = {
    force = true;
    text = ''
      {
        "enable-crash-reporter": false,
        "password-store": "gnome-libsecret"
      }
    '';
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

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ];
    };
  };

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
