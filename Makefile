asdf:
	@git clone https://github.com/asdf-vm/asdf.git ~/.asdf

task:
	@sh -c "`curl --location https://taskfile.dev/install.sh`" -- -d -b ~/.local/bin

fzf:
	@git -C ~/.fzf pull 2>/dev/null || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

tools:
	@cargo install -f bat \
		difftastic \
		eza \
		fd-find \
		hexyl \
		jnv \
		ripgrep \
		sd \
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

wezterm.sh:
	@curl -L https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh -o .config/wezterm/wezterm.sh

plug.vim:
	@curl -fLo .config/nvim/autoload/$@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/$@

spell/%.spl:
	@curl -fLo .config/nvim/$@ --create-dirs http://ftp.vim.org/pub/vim/runtime/$@

spell: spell/pt.utf-8.spl spell/en.utf-8.spl
