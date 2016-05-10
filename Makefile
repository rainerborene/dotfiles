GITHUB=https://raw.githubusercontent.com
CURL=@curl --create-dirs -fLo

clean:
	@rm -v .config/nvim/autoload/plug.vim
	@rm -v .config/nvim/spell/pt.utf-8.spl
	@rm -v .config/nvim/spell/en.utf-8.spl

.config/nvim/autoload/plug.vim:
	$(CURL) $@ $(GITHUB)/junegunn/vim-plug/master/plug.vim

.config/nvim/spell/pt.utf-8.spl:
	$(CURL) $@ http://ftp.vim.org/pub/vim/runtime/spell/pt.utf-8.spl

.config/nvim/spell/en.utf-8.spl:
	$(CURL) $@ http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl

dependencies: .config/nvim/autoload/plug.vim .config/nvim/spell/en.utf-8.spl .config/nvim/spell/pt.utf-8.spl

.PHONY: dependencies clean
