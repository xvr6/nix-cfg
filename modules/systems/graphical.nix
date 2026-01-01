{ inputs, pkgs, username, ...}: {
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

    services.displayManager.sddm.enable = true;
    services.displayManager.autoLogin = {
        enable = false;
        user = username;
    };
   
    services.desktopManager.plasma6.enable = true;

    # desktop/window managers or whatchamacallet
    # services.getty.autologinUser = username;
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

}
