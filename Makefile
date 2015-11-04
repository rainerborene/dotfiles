GITHUB=https://raw.githubusercontent.com
CURL=@curl --create-dirs -fLo

dependencies: .config/nvim/autoload/plug.vim .zsh/base16-ocean.dark.sh

.config/nvim/autoload/plug.vim:
	$(CURL) $@ $(GITHUB)/junegunn/vim-plug/master/plug.vim

.zsh/base16-ocean.dark.sh:
	$(CURL) $@ $(GITHUB)/chriskempson/base16-shell/master/base16-ocean.dark.sh

clean:
	@rm -v .config/nvim/autoload/plug.vim .zsh/base16-ocean.dark.sh

oh-my-zsh:
	@sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

.PHONY: dependencies clean oh-my-zsh
