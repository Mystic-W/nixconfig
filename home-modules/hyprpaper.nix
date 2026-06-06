{ ... }:

{
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [
        "${../wallpapers/wallpaper.jpg}"
      ];

      wallpaper = [
        ",${../wallpapers/wallpaper.jpg}"
      ];
    };
  };
}
