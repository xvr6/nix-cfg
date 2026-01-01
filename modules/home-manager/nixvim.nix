{ inputs, pkgs, ... }: {
     imports = [
	    inputs.nixvim.homeModules.nixvim
    ];

    programs.nixvim = {
    	enable = true;
       	viAlias = true;
    	vimAlias = true;
	    defaultEditor = true;

    	# globals.mapleader = "~~~~";
	
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
      #     lualine = {
      #         enable = true;
      #     };
           #TODO: continue implementing lazygit 
            lazygit = {
                enable = false;
                settings = {
                    floating_window_winblend = 0;
                    floating_window_scaling_factor = 0.9;
                    };
            };

            todo-comments.enable = true;

            telescope = {
                enable = true;
            };

            nvim-tree = {
                enable = true;
   	    	    openOnSetup = true;
   		    	openOnSetupFile = true;
        	};
	        
           # nvim-cmp = { 
            #    enable = true;
              #  autoEnableSources = true;
             #   sources = [
               #     {name = "nvim_lsp";}
##                    {name = "path";}
                #];
            #};
    
            lightline.enable = true;
		    
            web-devicons = { # required by nvim-tree
    	   		enable = true;	
    		};

            highlight-colors.enable = true;

	    	lsp = {
		    	enable = true;
			    servers = {
			    	nixd.enable = true;
		    	};
	    	};
            
            lsp-status = {
                enable = true;
            };

    };



    };
}
