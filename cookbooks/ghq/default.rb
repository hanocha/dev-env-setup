execute 'go get ghq' do
  user node.user.name
  command 'env GOPATH="/home/hanocha/go" /usr/local/go/bin/go get github.com/motemen/ghq'
end
