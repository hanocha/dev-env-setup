execute 'go get ghq' do
  user node.user.name
  command "env GOPATH='/home/#{node.user.name}/go' /usr/local/go/bin/go get github.com/motemen/ghq"
  not_if "ls /home/#{node.user.name}/go/bin/ghq"
end
