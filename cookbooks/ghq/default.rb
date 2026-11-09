brew_bin = "/home/linuxbrew/.linuxbrew/bin/brew"
ghq_bin = "/home/linuxbrew/.linuxbrew/bin/ghq"

execute "install ghq by brew" do
  user node.user.name
  command "#{brew_bin} install ghq"
  not_if "test -x #{ghq_bin}"
end
