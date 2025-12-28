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
	
        colorschemes.tokyonight = {
            enable = true;
            settings.style = "night";
        };

	    plugins = {
      #     lualine = {
      #         enable = true;
      #     };
           #TODO: continue implementing lazygit 
            lazygit = {
                enable = true;
                settings = {
                    floating_window_winblend = 0;
                    floating_window_scaling_factor = 0.9;
                    };
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
