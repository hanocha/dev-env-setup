execute 'install ghq by go install' do
  user node.user.name
  command "/home/linuxbrew/.linuxbrew/bin/brew install ghq"
  not_if "which ghq"
end
