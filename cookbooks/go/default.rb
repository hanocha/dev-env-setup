home_dir = "/home/#{node.user.name}"

execute 'download go 1.16 binary' do
  user node.user.name
  cwd home_dir
  command 'wget https://golang.org/dl/go1.16.linux-amd64.tar.gz'
  not_if "ls #{home_dir}/go1.16.linux-amd64.tar.gz"
end

execute 'decompless go binary tarball' do
  command "tar -C /usr/local -xzf #{home_dir}/go1.16.linux-amd64.tar.gz"
  not_if 'ls /usr/local/go'
end

execute 'add go pathes into .zshrc' do
  user node.user.name
  command %|
  echo 'set -x GOROOT /usr/local/go' >> /home/#{node.user.name}/.config/fish/config.fish
  echo 'set -x GOPATH $HOME/go' >> /home/#{node.user.name}/.config/fish/config.fish
  echo 'set -x PATH $GOROOT/bin $GOPATH/bin $PATH' >> /home/#{node.user.name}/.config/fish/config.fish
|
  not_if "cat #{home_dir}/.config/fish/config.fish | grep 'set -x PATH $GOROOT/bin $GOPATH/bin $PATH'"
end
