{ inputs, pkgs, ... }: {
  #Install nixvim and dependencies
  home.packages = with pkgs; [ #dependencies... none for now?
  ];

 imports = [
	inputs.nixvim.homeModules.nixvim
 ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  
	#language server cfg
  	lsp.servers = {
		inlayHints.enable = true;

		"*".config = {
				# Global Defaults
				root_markets = [".git"];
			};

		"vue_ls" = {
			enable = true;
			config = {
				filetypes = ["vue"];
			};
		};
	
	};

	plugins = {
		nvim-tree = {
			enable = true;
			openOnSetup = true;
			openOnSetupFile = true;
		};
		
		web-devicons = { # required by nvim-tree
			enable = true;	
		};	
	};

  };
} 
