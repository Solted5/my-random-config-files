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

  networking.hostName = "saltnix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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

  # Make Davinci Resolve work
   hardware.opengl = {
   enable = true;
   extraPackages = with pkgs; [
     rocmPackages.clr.icd
   ];
 };

  # Use fish as default shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Enable num-lock on boot
  services.displayManager.sddm.autoNumlock = true;

# flatpaks
services.flatpak.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.solted = {
    isNormalUser = true;
    description = "Solted";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
kdePackages.kate
tor
davinci-resolve
flameshot
tor-browser-bundle-bin
mullvad-vpn
librewolf-unwrapped
melonDS
gnome.gnome-disk-utility
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install Steam
  programs.steam.enable = true;

  # Use mullvad
  services.mullvad-vpn.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    eza
gcc
gnumake
pkgs.starship
qbittorrent-qt5
fish
alacritty
neofetch
pfetch
nitch
btop
ipfetch
mullvad
git
starship
nodePackages.pnpm
nodejs
curl
temurin-bin-8
temurin-bin-11
temurin-bin-16
temurin-bin-17
temurin-bin-19
temurin-bin-21
temurin-bin
vlc
appimage-run
linuxHeaders
neovim
    (prismlauncher.override {
      jdks = [
       temurin-bin-8
       temurin-bin-11
       temurin-bin-16
       temurin-bin-17
       temurin-bin-19
       temurin-bin-21
       temurin-bin
      ];
    })
  ];

fonts.packages = with pkgs; [
twitter-color-emoji
twemoji-color-font
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
(nerdfonts.override { fonts = [ "JetBrainsMono" "Mononoki" ]; })
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
   networking.firewall.allowedTCPPorts = [ 80 443 25565 ];
   networking.firewall.allowedUDPPorts = [ 80 443 25565 ];
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
