# sudo nixos-rebuild switch --flake ~/.config/nixos/#myNixos
{ config, pkgs, ... }:
{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    programs.hyprland.enable = true;
  
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "Xbox360"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Kyiv";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "uk_UA.UTF-8";
        LC_IDENTIFICATION = "uk_UA.UTF-8";
        LC_MEASUREMENT = "uk_UA.UTF-8";
        LC_MONETARY = "uk_UA.UTF-8";
        LC_NAME = "uk_UA.UTF-8";
        LC_NUMERIC = "uk_UA.UTF-8";
        LC_PAPER = "uk_UA.UTF-8";
        LC_TELEPHONE = "uk_UA.UTF-8";
        LC_TIME = "uk_UA.UTF-8";
    };

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jomm = {
        isNormalUser = true;
        description = "Jomm";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    security.rtkit.enable = true;
	services.pipewire = {
	    enable = true;
	    alsa.enable = true;
	    alsa.support32Bit = true;
	    pulse.enable = true;
	# If you want to use JACK applications, uncomment this
	#jack.enable = true;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
  	    brightnessctl
	    discord
	    dunst
	    exa
	    firefox
	    fish
	    gcc
	    git
	    gimp
	    htop
	    kitty
	    libnotify
	    neofetch
	    neovim
	    nodejs
	    playerctl
	    p7zip
        qbittorrent
	    rofi
        steam
	    swaybg
	    telegram-desktop
	    unzip
    	(waybar.overrideAttrs (oldAttrs: {
		        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		    })
	    )
    	wine
        winetricks
	    xfce.thunar
    ];
    fonts.packages = with pkgs; [
        font-awesome
        source-code-pro
        nerdfonts

        ## nerdfonts
        # (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
    ];


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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}
