execute 'go get peco' do
  user node.user.name
  command "env GOPATH='/home/#{node.user.name}/go' /usr/local/go/bin/go get github.com/peco/peco/cmd/peco"
  not_if "ls /home/#{node.user.name}/go/bin/peco"
end

execute 'set alias' do
  command %[echo 'alias gmv="cd (ghq root)/(ghq list | peco)"' >> /home/#{node.user.name}/.config/fish/config.fish]
  not_if "grep 'alias gmv' /home/#{node.user.name}/.config/fish/config.fish"
end
