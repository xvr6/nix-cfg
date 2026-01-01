{ inputs, pkgs, ... }: {
     imports = [
	    inputs.nixvim.homeModules.nixvim
    ];

    programs.nixvim = {
    	enable = true;
       	viAlias = true;
    	vimAlias = true;
	    defaultEditor = true;

	    #nvim options
    	opts = {
		    #line numbers
	    	number = true;
    		relativenumber =  true;
	
		    #tab settings
		    tabstop = 4;
	    	shiftwidth = 4;
		    softtabstop = 4;
	    	expandtab = true;
    		shiftround = true;
	    	autoindent = true;
		    smartindent = true;
    	};
	
	    plugins = {
            # TODO: continue implementing lazygit and the 2 plugins below.
            lazygit = {
                enable = false;
                settings = {
                    floating_window_winblend = 0;
                    floating_window_scaling_factor = 0.9;
                };
            };

            telescope = {
                enable = true;
            };

            nvim-tree = {
                enable = true;
   	    	    openOnSetup = true;
   		    	openOnSetupFile = true;
        	};
		    # nvim tree dependancy
            web-devicons.enable = true;	

            # -- Completion --
            cmp = {
                enable = true;
                autoEnableSources = true;
                settings.soruces = [
                    { name = "nvim_lsp"; }
                    { name = "path"; }
                    { name = "buffer"; }
                ];
            };


            # -- Language Server Protocol --
	    	lsp.enable = true;
            lsp.servers = {
			    nixd.enable = true;
                vue_ls.enable = true;

		    };

            # -- Cosmetic Tweaks --
            todo-comments.enable = true;
            lightline.enable = true;
            highlight-colors.enable = true;
        };
    };
}
