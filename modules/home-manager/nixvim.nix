{ inputs, pkgs, ... }: {
  #Install neovim and dependencies
  home.packages = with pkgs; [ #dependencies
  ];

 imports = [
	inputs.nixvim.homeModules.nixvim
 ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  
	plugins = {
		nvim-tree = {
			enable = true;
			openOnSetup = true;
			openOnSetupFile = true;
		};
		lsp = {
			enable = true;
		};
		
		lsp-status = {
			enable = true;
		};
		web-devicons = {
			enable = true;	
		};	
	};

  };
} 
