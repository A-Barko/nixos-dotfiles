{ config, lib, pkgs, ... }:

{
  imports =
    [ 
    ./hardware-configuration.nix
    ];

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "barkopc"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "America/Montreal";

  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  services.power-profiles-daemon.enable = true;

  services.displayManager.ly.enable = true;

  users.users.barko = {
    isNormalUser = true;
    description = "Barko Style THE GOAT";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true; 
  };

  programs.niri.enable = true;

  programs.firefox.enable = true;

  programs.neovim = {
      enable =true;
      defaultEditor = true;
  };

  programs.steam.enable = true;

  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
	  neovim
	  wget
	  git
	  niri
	  alacritty
  ];

  fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
	  nerd-fonts.blex-mono
      ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";

}

