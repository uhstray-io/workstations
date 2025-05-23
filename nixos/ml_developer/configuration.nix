# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# This NixOS configuration is designed to streamline setting up a developers laptop for machine learning exercises
# You can get NixOS here : https://nixos.org/download/
# See the NixOS Manual here : https://nixos.org/manual/nixos/stable/
# On your local machine, this file should be located in /etc/nixos/configuration.nix
# To rebuild after a configuration change use `nixos-rebuild switch --use-remote-sudo`
# See another nerds configuration here : https://github.com/JacobHaig/nixos-config/blob/main/configuration.nix

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan. This file is typically generated automatically, you can modify configuration.nix to update manually 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "your-machine-hostname"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant, does not work if Network Manager is enabled.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Set target for local network gateway, if not set will auto-discovery default network gateway
  # networking.defaultGateway = "192.168.1.1";
  
  # Set target nameservers to Cloudflare
  networking.nameservers = [ "1.1.1.1" ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Enable flatpak applications
  services.flatpak.enable = true;

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

  virtualisation.docker.enable = true;

  # Set ZSH as default shell for all users
  users.defaultUserShell=pkgs.zsh;

  environment.shells = with pkgs; [ zsh ];


  # Enable ZSH Terminal
  programs.zsh = {
    # enableCompletions = true;
    # autosuggestions.enable = true;
    # syntaxHighlighting.enable = true;
    # history.size = 10000;
    enable = true;

    ohMyZsh = {

      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
      
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.myAccountLogin = {
    isNormalUser = true;
    description = "Your Name or Description for the Account";
    extraGroups = [ "networkmanager" "wheel" "docker" ]; #add your user to the docker group for root based docker access
    packages = with pkgs; [
      # Define user specific passages here, can be left empty for single-user devices
    ];
  };

  # Install firefox
  programs.firefox.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  
  # Brave Web Browser
  brave

  # cURL 
  curl

  #Discord
  discord

  #Docker Resources
  docker
  docker-client

  #Git, Github Desktop, and Github Actions
  git
  github-desktop
  gnomeExtensions.github-actions

  # GNU Compiler Collection
  gcc

  # GO Language Support
  go
  templ # Language for writing HTML user interfaces in Go
  air # Live reload for Go apps

  # Javascript for those sickos
  nodejs
  bun

  # Local Kubernetes Development
  minikube

  # Nvidia ML Container Toolkit
  nvidia-container-toolkit

  #Neovim, because vim, emacs, nano, and even neovim are all awful
  neovim

  # Latest Python Version
  python314

  # Proton Suite
  protonmail-bridge
  protonmail-desktop
  proton-pass

  #PostgreSQL Database
  postgresql

  #Rust Language Support
  rustup

  # RustDesk Remote Desktop Client
  rustdesk

  # What you gettin?
  wget

  # VSCode Editor
  vscode
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
  services.openssh.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
