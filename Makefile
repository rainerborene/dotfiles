GITHUB=https://raw.githubusercontent.com
CURL=@curl --create-dirs --progress-bar -fLo
DOTFILES=.agignore    \
		 .ctags       \
		 .curlrc      \
		 .gemrc       \
		 .gitconfig   \
		 .hushlogin   \
		 .irbrc       \
		 .pryrc       \
		 .psqlrc      \
		 .railsrc     \
		 .rubocop.yml \
		 .tmux.conf   \
		 .hyper.js    \
		 .zshrc

deps: .config/nvim/* $(HOME)/.tmux/plugins/tpm

install:
	@ln -sv $(DOTFILES) $(HOME)

clean:
	@rm -v .config/nvim/autoload/plug.vim
	@rm -v .config/nvim/spell/pt.utf-8.spl
	@rm -v .config/nvim/spell/en.utf-8.spl
	@rm -rf $(HOME)/.tmux/

.config/nvim/autoload/plug.vim:
	$(CURL) $@ $(GITHUB)/junegunn/vim-plug/master/plug.vim

.config/nvim/spell/pt.utf-8.spl:
	$(CURL) $@ http://ftp.vim.org/pub/vim/runtime/spell/pt.utf-8.spl

.config/nvim/spell/en.utf-8.spl:
	$(CURL) $@ http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl

$(HOME)/.tmux/plugins/tpm:
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

.PHONY: deps install clean
