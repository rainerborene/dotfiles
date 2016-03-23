GITHUB=https://raw.githubusercontent.com
CURL=@curl --create-dirs -fLo

bin/tmuxwords.rb:
	$(CURL) $@ $(GITHUB)/junegunn/dotfiles/master/bin/tmuxwords.rb

.config/nvim/autoload/plug.vim:
	$(CURL) $@ $(GITHUB)/junegunn/vim-plug/master/plug.vim

clean:
	@rm -v .config/nvim/autoload/plug.vim
	@rm -v bin/tmuxwords.rb

zsh:
	@sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

dependencies: .config/nvim/autoload/plug.vim bin/tmuxwords.rb

.PHONY: dependencies clean zsh
