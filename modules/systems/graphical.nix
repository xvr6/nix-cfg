{ pkgs, username, ...}: {
	imports = [
		./common.nix
	];

	# Enable CUPS to print documents.
	# services.printing.enable = true;

	# Enable sound.
	# services.pulseaudio.enable = true;
	# OR
	# services.pipewire = {
	#   enable = true;
	#   pulse.enable = true;
	# };

	# Enable touchpad support (enabled default in most desktopManager).
	# services.libinput.enable = true;

    #desktop/window managers or whatchamacallet
    services.displayManager = {
        sddm = {
            enable = true;
            wayland.enable = true;
        };
        autoLogin = {
            enable = true;
            user = username;
        };
    };


    # services.desktopManager.plasma6.enable = true;
    
    programs.hyprland.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    environment.systemPackages = with pkgs; [
        waybar 
        hyprpaper #wallpaper manager
        kitty #default for hyprland
        dunst #notification manager
        libnotify #dependancy for abovei
        
        rofi # app launcher
    ];


    fonts.packages = with pkgs; [
        rubik
        nerd-fonts.ubuntu
        nerd-fonts.jetbrains-mono
    ];


}
