# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Automatic Garbage Collection
  nix.gc = {
	  automatic = true;
	  dates = "weekly";
	  options = "--delete-older-than 7d";
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.russ = {
    isNormalUser = true;
    description = "russ";
    extraGroups = [ "networkmanager" "wheel" "docker" "uinput" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   unzip
   wget
   htop
   hugo
   jq
   ncdu
   neovim
   git
   git-lfs
   tldr
   tmux
   tree
   zoxide
   cmatrix
   ripgrep
   fd
   vscode
   hollywood
   home-manager
   gcc
   alacritty
   nodejs
   cypress # Testing library
   playwright # Testing library
   # haskellPackages.ghcup # BROKEN
   luajitPackages.luarocks
   python3
   discord
   # azuredatastudio # BROKEN
   azure-cli
   kanata
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # docker
  virtualisation.docker.enable = true;

  # kanata
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
        ;; defsrc is still necessary
       (defsrc
         caps a s d f j k l ;
       )
      (defvar
        tap-time 150
        hold-time 200
      )

      (defalias
        escctrl (tap-hold 100 100 esc lctl)
        a (tap-hold $tap-time $hold-time a lmet)
        s (tap-hold $tap-time $hold-time s lalt)
        d (tap-hold $tap-time $hold-time d lsft)
        f (tap-hold $tap-time $hold-time f lctl)
        j (tap-hold $tap-time $hold-time j rctl)
        k (tap-hold $tap-time $hold-time k rsft)
        l (tap-hold $tap-time $hold-time l ralt)
        ; (tap-hold $tap-time $hold-time ; rmet)
      )

      (deflayer base
        @escctrl @a @s @d @f @j @k @l @;
      )
      '';
    };
  };
};

  # 

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
