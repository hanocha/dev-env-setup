execute 'go get ghq' do
  user node.user.name
  command "/usr/local/go/bin/go get github.com/x-motemen/ghq"
  not_if "ls /home/#{node.user.name}/go/bin/ghq"
end
