execute 'install ghq by go install' do
  user node.user.name
  command "/usr/local/go/bin/go install github.com/x-motemen/ghq@latest"
  not_if "ls /home/#{node.user.name}/go/bin/ghq"
end
