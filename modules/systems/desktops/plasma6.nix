{ inputs, pkgs, username, ...}: {
	imports = [
		../common.nix
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

    services.displayManager.sddm.enable = true;
    services.displayManager.autoLogin = {
        enable = true;
        user = username;
    };
   
    services.desktopManager.plasma6.enable = true;
}
