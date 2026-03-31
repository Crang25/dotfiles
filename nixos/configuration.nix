# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  customDwm = pkgs.callPackage ./pkgs/dwm.nix { };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable USB storage kernel modules
  boot.kernelModules = [ "usb_storage" "uas" ];

  # Enable services for auto-mounting
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;  # Needed for file managers to auto-mount
  # Enable udev for automatic mounting
  services.udev.enable = true;

  # For NTFS/exFAT support
  boot.supportedFilesystems = [ "ntfs" "exfat" "vfat" ];


  # Add udev rules for allowing users to mount drives
  services.udev.extraRules = ''
    # Allow users in plugdev group to mount USB storage devices
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0664", GROUP="plugdev"
    SUBSYSTEM=="block", ENV{ID_BUS}=="usb", MODE="0660", GROUP="plugdev"
  '';
  
  # Enable fuse for user mounts
  programs.fuse.userAllowOther = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false; # Better performance
  };

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";


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
  services.displayManager.defaultSession = "none+bspwm";
  services.xserver = {
    enable = true;
    windowManager = {
      bspwm.enable = true;
      dwm = {
        enable = true;
        package = customDwm;
        extraSessionCommands = ''
          ${pkgs.bash}/bin/bash "$HOME/.config/dwm/autostart.sh" &
        '';
      };
    };
    # displayManager = {
    #   lightdm.enable = true;
    #   # defaultSession = "none+bspwm";
    #
    #   sessionCommands = ''
    #     # Set X11 cursor
    #     ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr
    #     
    #     # Set GTK cursor
    #     export XCURSOR_THEME=Adwaita
    #     export XCURSOR_SIZE=24
    #   '';
    # };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.xserver.displayManager.lightdm = {
    enable = true;
    # Keep the greeter wallpaper inside the flake so pure evaluation works
    # and the lightdm user can always read it from the store.
    background = ./assets/dock.png;

    greeters.gtk = {
      theme = {
        package = pkgs.gruvbox-dark-gtk;
        name = "gruvbox-dark";
      };
      iconTheme = {
        package = pkgs.gruvbox-dark-icons-gtk;
        name = "oomox-gruvbox-dark";
      };
      cursorTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 24;
      };
      clock-format = "%a, %d %b %H:%M";
      indicators = [
        "~host"
        "~spacer"
        "~clock"
        "~spacer"
        "~session"
        "~language"
        "~a11y"
        "~power"
      ];
      extraConfig = ''
        font-name = JetBrainsMono Nerd Font 12
        xft-antialias = true
        xft-hintstyle = hintslight
        xft-rgba = rgb
      '';
    };
  }; 

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      scrollMethod = "twofinger";
    };
    # naturalScrolling = true;  # Reverses scroll direction
    # tapping = true;           # Enable tap-to-click
    # scrollMethod = "twofinger";
  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable BSPWM Display Manager
  # services.xserver.windowManager.bspwm.enable = true;
  # Enable a display manager (lightdm is lightweight and works well with BSPWM)
  # services.xserver.displayManager.lightdm.enable = true;
  # services.displayManager.defaultSession = "none+bspwm";

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  services.openvpn.servers = {
    hoChoMinhVPN  = {
      # config = '' config /home/violin/Downloads/configs/yerevan_tcp.conf '';
      config = "config /etc/nixos/vpn/ho_chi_minh_tcp.conf";
      updateResolvConf = true;
      autoStart = false;
    };
    yerevanVPN  = {
      # config = '' config /home/violin/Downloads/configs/yerevan_tcp.conf '';
      config = "config /etc/nixos/vpn/yerevan_tcp.conf";
      updateResolvConf = true;
      autoStart = false;
    };
    helsinkiVPN  = {
      # config = '' config /home/violin/Downloads/configs/helsinki_tcp.conf '';
      config = "config /etc/nixos/vpn/helsinki_tcp.conf";
      updateResolvConf = true;
      autoStart = false;
    };
    frankfurtVPN  = {
      # config = '' /home/violin/Downloads/configs/frankfurt_1_tcp.conf '';
      config = "config /etc/nixos/vpn/frankfurt_1_tcp.conf";
      updateResolvConf = true;
      autoStart = false;
    };
  };
  
  # Ensure the openvpn user can read the config files
  system.activationScripts.openvpn-permissions = ''chmod 644 /etc/nixos/vpn/*.conf'';


  location.latitude = "40.1568604087553";
  location.longitude = "44.513478292495";
  services.redshift = {
    # Manual location (replace with your coordinates)
    # latitude = "40.1568604087553";   # Example: Yerevan latitude
    # longitude = "44.513478292495";  # Example: Yerevan longitude

    # Temperature settings
    temperature = {
      day = 4500;    # Neutral daylight (6500K is pure white)
      night = 3500;  # Warm light (adjust between 3000-4500) (lower = more orange)
    };

    # Brightness adjustments (optional)
    brightness = {
      day = "0.8";    # 80% brightness
      night = "0.7";  # 70% brightness
    };
  };

  # Configure cursor theme system-wide
  programs.dconf.enable = true;
  
  # Set default cursor theme
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Adwaita
    gtk-cursor-theme-size=24
  '';

  
  fonts.packages = with pkgs; [ 
    # setting nerdfonts 
    pkgs.nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];


  # read https://wiki.nixos.org/wiki/Nix-ld
  programs.nix-ld.enable = true;

  services.netbird.enable = true;

  # storage optimization during every build
  nix.settings.auto-optimise-store = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";     # zstd is default and best compression/speed tradeoff
    memoryPercent = 100;     # how much of RAM to use for zram (default: 50)
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.violin = {
    isNormalUser = true;
    description = "violin";
    extraGroups = [ "networkmanager" "wheel" "bluetooth" "audio" "storage" "disk" "plugdev" "docker" "libvirtd" "kvm" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # neccessary tools
      zsh
      kitty
      tmux
      neovim
      distrobox
      keepassxc
      google-chrome
      xclip               # Tool to access the X clipboard from a console application
      jetbrains-toolbox

      # AI
      opencode

      slack
      telegram-desktop
      lazygit             # Convenient terminal-ui
      ripgrep             # recursively searches directories for a regex pattern while respecting your gitignore (for make grep search for TreeSitter)
      docker
      docker-compose
      zoom-us

      emacs # super cool text editor
      warpd # mouseless tool

      # virtualisation
      drawterm
      qemu
      virt-manager

      # fancy, buitiful or useful utils
      dua
      ags                 # widgets for terminal
      btop                # Monitor of resources(system monitor)
      fastfetch           # neofetch like system information tool
      yazi                # terminal file manager
      fzf                 # for fzf search in terminal
      qbittorrent         # Torrent client
      vlc                 # Video player
      xfce.thunar         # file manager
      flameshot           # screenshot tool
      brightnessctl       # This program allows you read and control device brightness
      redshift            # to make screen color warmer for eyes. Screen color temperature manager
      libnotify           # Desktop notification manager
      unzip               # Archive/Extract zip files
      spotify             # Spotify client
      jq                  # Lightweight and flexible command-line JSON processor
      playerctl           # Command-line utility and library for controlling media players that implement MPRIS
      calcurse            # Calendar and scheduling application for the command line
      obs-studio          # Screen recorder
      kdePackages.okular  # Books reader
    ];
  };

  # Install firefox.
  # programs.firefox.enable = true;
  # For system-wide configuration
  programs.firefox = {
    enable = true;
    # For NixOS 23.11 or newer
    # preferences = {
    #   "widget.content.gtk-theme-override" = "Arc-Dark";
    # };
    package = pkgs.firefox.override {
      cfg = {
        enableGnomeExtensions = true;
      };
    };
    preferences = {
      "browser.theme.dark-private-windows" = true;
      "browser.in-content.dark-mode" = true;
      "ui.systemUsesDarkTheme" = 1;
      "widget.content.gtk-theme-override" = "Arc-Dark";
    };
  };


  # Setting zsh as SHELL
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  virtualisation.docker = {
    enable = true;
    # Optional: Enable Docker on boot
    # enableOnBoot = true;
  };

  # for virtual machines
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git

    # fow BSPWM
    dmenu  # Application launcher used by BSPWM
    bspwm                 # Window manager
    sxhkd                 # Hotkey daemon
    pamixer               # Pulseaudio command line mixer
    polybar               # Status bar
    rofi                  # Application launcher
    networkmanager
    networkmanagerapplet  # NetworkManager control applet for GNOME
    blueman # GUI manager
    bluez
    bluez-tools
    dunst                 # Notification daemon
    picom                 # Compositor
    feh                   # Image viewer/wallpaper setter
    acpi                  # Advanced Configuration and Power Interface
    xdotool               # X11 automation/debugging helper during dwm migration
    wmctrl                # Window inspection helper during dwm migration

    # Dark theme packages
    arc-theme
    papirus-icon-theme
    adwaita-qt
    adwaita-icon-theme

    # for disk managment
    usbutils       # For lsusb
    pciutils       # For lspci
    parted         # For disk partitioning
    gparted        # GUI for disk partitioning
    ntfs3g         # For NTFS support
    exfat          # For exFAT support
    udiskie        # Auto-mounting tool
    hdparm         # Disk health testing

    efibootmgr     # Boot manager
  ];

  # GTK theme configuration
  environment.sessionVariables = {
    GTK_THEME = "Arc-Dark";
    QT_STYLE_OVERRIDE = "gtk2";
    XDG_CONFIG_HOME = "$HOME/.config";
  };


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
  system.stateVersion = "24.11"; # Did you read the comment?

}
