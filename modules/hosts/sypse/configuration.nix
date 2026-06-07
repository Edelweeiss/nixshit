{ self, inputs, config, pkgs, lib, ... }: {
  flake.nixosModules.sypseConfiguration = { pkgs, lib, config, ... }: {
    imports = [
      self.nixosModules.sypseHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
	nixpkgs.config.packageOverrides = pkgs: {
	  openldap = pkgs.openldap.overrideAttrs (old: {
		doCheck = false;
	  });
	};

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    services.pulseaudio.enable = false;
	programs.xfconf.enable = true;
	services.gvfs.enable = true;
	xdg.portal = {
	  enable = true;
	  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	  config.common.default = "*";
	};

	programs.steam = {
		enable = true;
	};
	programs.thunar.enable = true;
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
		  ll = "ls -l";
		  update = "sudo nixos-rebuild switch --flake .#sypse";
		};

		histSize = 10000;
		histFile = "$HOME/.zsh_history";
		setOptions = [
		  "HIST_IGNORE_ALL_DUPS"
		];
		ohMyZsh = {
		  enable = true;
		  plugins = [
			"git"
			"z"
		  ];
		  theme = "robbyrussell";
		};
	};
	environment.shells = [ pkgs.zsh ];

	networking.hostName = "ThyHost";
	networking.networkmanager.enable = true;
	time.timeZone = "Asia/Kolkata";

	i18n.defaultLocale = "en_IN";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_IN";
		LC_IDENTIFICATION = "en_IN";
		LC_MEASUREMENT = "en_IN";
		LC_MONETARY = "en_IN";
		LC_NAME = "en_IN";
		LC_NUMERIC = "en_IN";
		LC_PAPER = "en_IN";
		LC_TELEPHONE = "en_IN";
		LC_TIME = "en_IN";
	};

	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	users.users.sypse = {
	   isNormalUser = true;
	   extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
	   password = "sypse";
	   shell = pkgs.zsh;
	};

	system.stateVersion = "25.11";

    environment.systemPackages = with pkgs; [
      firefox
      vim
      neovim
      ghostty
	  git
	  rustup
	  unzip
	  ripgrep
	  gh
	  adwaita-icon-theme
	  lutris
	  qbittorrent
    ];

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
