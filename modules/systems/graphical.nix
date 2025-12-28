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
	services.displayManager.sddm.enable = true;
	services.displayManager.sddm.autoLogin.relogin = true;
	services.displayManager.autoLogin.user = username;
	services.displayManager.autoLogin.enable = true;
	
    services.desktopManager.plasma6.enable = true;
	
    programs.hyprland.enable = true;
    services.geoclue2.enable = true;

    fonts.packages = with pkgs; [
        rubik
        nerd-fonts.ubuntu
        nerd-fonts.jetbrains-mono
    ];


}
