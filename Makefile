asdf:
	@git clone https://github.com/asdf-vm/asdf.git ~/.asdf

kitty:
	@curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

task:
	@sh -c "`curl --location https://taskfile.dev/install.sh`" -- -d -b ~/.local/bin

fzf:
	@git -C ~/.fzf pull 2>/dev/null || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

tools:
	@cargo install -f bat \
		bottom \
		eza \
		fd-find \
		git-delta \
		hexyl \
		ripgrep \
		sd \
		starship \
		zoxide

gems:
	@gem install easy_translate \
		erb_lint \
		foreman \
		i18n-tasks \
		ripper-tags \
		rubocop \
		rubocop-minitest \
		rubocop-performance \
		rubocop-rails \
		solargraph \
		solargraph-rails

chromedriver:
	curl -sS -o /tmp/chromedriver_linux64.zip "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chrome-headless-shell-linux64.zip"
	unzip /tmp/chromedriver_linux64.zip -d /tmp/chromedriver
	sudo mv /tmp/chromedriver/chrome-headless-shell /usr/local/bin/chromedriver

plug.vim:
	@curl -fLo .config/nvim/autoload/$@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/$@

spell/%.spl:
	@curl -fLo .config/nvim/$@ --create-dirs http://ftp.vim.org/pub/vim/runtime/$@

spell: spell/pt.utf-8.spl spell/en.utf-8.spl
