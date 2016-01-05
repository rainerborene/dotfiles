GITHUB=https://raw.githubusercontent.com
CURL=@curl --create-dirs -fLo

.config/nvim/autoload/plug.vim:
	$(CURL) $@ $(GITHUB)/junegunn/vim-plug/master/plug.vim

clean:
	@rm -v .config/nvim/autoload/plug.vim

zsh:
	@sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

dependencies: .config/nvim/autoload/plug.vim

.PHONY: dependencies clean zsh
