{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    # Use the Hyprland package and portal from the NixOS module.
    package = null;
    portalPackage = null;

    settings = {
      
      animations = {
        enabled = true;

	bezier = [
	  "quick, 0.05, 0.7, 0.1, 1.0"
	];

	animation = [
	  "windows, 1, 2, quick"
	  "windowsOut, 1, 2, quick, popin 80%"
	  "border, 1, 3, quick"
	  "fade, 1, 2, quick"
	  "workspaces, 1, 2, quick"
	];
      };

      bind = [ 
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT, 0, movetoworkspacesilent, 10"


      	"$mod, T, exec, kitty"
	      "$mod, R, exec, rofi -show drun"
	      "$mod, Q, killactive"

	      "$mod, left, movefocus, l"
	      "$mod, right, movefocus, r"
	      "$mod, up, movefocus, u"
	      "$mod, down, movefocus, d"
      ];

      bindel = [
        # Volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
	", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

	# Brightness
	", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
	", XF86MonBrightnessDown, exec, brightnessctl --min-value=40 set 10%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      device = {
        name = "syna2ba6:00-06cb:cefe-touchpad";
        accel_profile = "adaptive";
        sensitivity= 0.25;
      };

      monitor = "eDP-1,preferred,auto,1";

      exec-once = [ 
        "waybar"
        "hyprpaper"
      ];

      "$mod" = "SUPER";

      input = {
        kb_layout = "latam";
        kb_variant = "";
        kb_model = "pc105";

        kb_options = "caps:unlock_on_press";

        # No mouse acceleration.
        accel_profile = "flat";

        touchpad = {
          disable_while_typing = true;
          clickfinger_behavior = false;
	        natural_scroll = true;
        };
      };

    };
  };
}
