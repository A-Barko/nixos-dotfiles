{ config, pkgs, ... }:
let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
        nvim = "nvim";
	ghostty = "ghostty";
	niri = "niri";
	noctalia = "noctalia";
	kicad = "kicad";
    };
in
{
    home.username = "orca";
    home.homeDirectory = "/home/orca";
    programs.git = {
	enable = true;
	settings = {
	    url."git@github.com:".insteadOf = "https://github.com/";
	    user = {
		name = "A-Barko";
		email = "abdelrahman.elbarkouky@mail.mcgill.ca";
	    };
	};
    };
    home.stateVersion = "26.05";
    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo I use nixos, btw";
        };
    };

    xdg.configFile = builtins.mapAttrs (name: subpath: {
    	source = create_symlink "${dotfiles}/${subpath}";
	recursive = false;
	})
	configs;

    home.packages = with pkgs; [
      neovim
      ripgrep
      nil
      nixpkgs-fmt
      gcc
      nodejs
      xwayland-satellite
      fuzzel
      swaybg
      swaylock
      ghostty
      noctalia-shell
      kicad-unstable
      jdk
      java-language-server
      lua-language-server
      unzip
      ltspice
      spotify
      slack
      chromium
      zip
      bat
      onlyoffice-desktopeditors
    ];
}
