{ inputs, pkgs, lib,  ... }: {

	programs.git = {
		enable = true;
		settings = {
			credential.helper = lib.getExe pkgs.gnupg;			
			user = {
				name = "xvr6";
				email = "xvr0612@gmail.com";
				init.defaultBranch = "main";

				#git cred. manager
				credential.helper = lib.mkForce ["manager"];
				credential.credentialStore = lib.mkForce ["secretservice"];
			};	
		};
	};
}
