brew_bin = "/home/linuxbrew/.linuxbrew/bin/brew"
nvim_bin = "/home/linuxbrew/.linuxbrew/bin/nvim"

# ghq と同様に Homebrew 経由で導入する。
# Homebrew の neovim は最新の安定版（0.10 以上）を配布している。
# バージョンを上げたい場合は手動で `brew upgrade neovim` を実行する。
execute "install neovim by brew" do
  user node.user.name
  command "#{brew_bin} install neovim"
  not_if "test -x #{nvim_bin}"
end
