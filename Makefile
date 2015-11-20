GITHUB=https://raw.githubusercontent.com
CURL=@curl --create-dirs -fLo

dependencies: .config/nvim/autoload/plug.vim

.config/nvim/autoload/plug.vim:
	$(CURL) $@ $(GITHUB)/junegunn/vim-plug/master/plug.vim

clean:
	@rm -v .config/nvim/autoload/plug.vim

oh-my-zsh:
	@sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

.PHONY: dependencies clean oh-my-zsh
