execute 'download go 1.7.5 binaly' do
  user node.user.name
  cwd '/home/hanocha'
  command 'wget https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz'
  not_if 'ls /home/hanocha/go1.7.5.linux-amd64.tar.gz'
end

execute 'decompless go binaly tarball' do
  command 'tar -C /usr/local -xzf /home/hanocha/go1.7.5.linux-amd64.tar.gz'
  not_if 'ls /usr/local/go'
end

execute 'add go pathes into .zshrc' do
  user node.user.name
  command %|echo "export PATH=$PATH:/usr/local/go/bin" >> /home/hanocha/.zshrc
echo "export GOPATH=/home/hanocha/go" >> /home/hanocha/.zshrc
|
  not_if 'grep "go/bin" /home/hanocha/.zshrc'
end
