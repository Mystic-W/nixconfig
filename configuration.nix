# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  programs.dconf.enable = true;

  hardware.enableRedistributableFirmware = true;


  programs.bash = {
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake $HOME/.config/nixos#trollface";
      nixcfg = "cd ~/.config/nixos";
    };

    interactiveShellInit = ''
      bind "set completion-ignore-case on"
      bind "set show-all-if-ambiguous on"
      bind "set completion-map-case on"
    '';
  };

  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "trollface"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
	
  # Set your time zone.
  time.timeZone = "America/Lima";
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.mystic= {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
	tree
	git
	vim
	neovim
	fish
	libxkbcommon
	vlc
	github-cli
     ];
   };
  
  programs.steam = {
    enable = true;

    # Optional: enable this to use Steam Remote Play.
    # remotePlay.openFirewall = true;

    # Optional: enable this to host Source dedicated servers.
    # dedicatedServer.openFirewall = false;

    # useful for many proton games, apparently
    protontricks.enable = true;
  };

  programs.gamemode.enable = true;

  services.xserver.enable = true;

  # Habilitar el gestor de pantalla GDM.
  services.displayManager.gdm.enable = true;

  # Habilitar el entorno de escritorio GNOME.
  services.desktopManager.gnome.enable = true;
  
  environment.gnome.excludePackages = with pkgs; [
    gnome-calendar
    gnome-weather
    simple-scan
    gnome-tour

    #test
    epiphany
    geary
    gnome-maps
    gnome-music
    gnome-contacts
    yelp
    totem
    gnome-console
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  services.xserver.xkb = {
    layout = "latam";
    variant = "";
    model = "pc105";
    };
  console.useXkbConfig = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

