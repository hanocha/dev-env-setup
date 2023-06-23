home_dir = "/home/#{node.user.name}"

execute 'download go binary' do
  user node.user.name
  cwd home_dir
  command "wget https://golang.org/dl/go#{node.goVersion}.linux-amd64.tar.gz -O go.tar.gz"
  not_if "ls #{home_dir}/go.tar.gz"
end

execute 'decompless go binary tarball' do
  command "tar -C /usr/local -xzf #{home_dir}/go.tar.gz"
  not_if "test -e /usr/local/go"
end

execute 'add /usr/local/go/bin into PATH' do
  user node.user.name
  command "echo 'set -x PATH /usr/local/go/bin $PATH' >> #{home_dir}/.config/fish/config.fish"
  not_if "grep 'set -x PATH /usr/local/go/bin $PATH' #{home_dir}/.config/fish/config.fish"
end

execute 'add ~/go/bin into PATH' do
  user node.user.name
  command "echo 'set -x PATH #{home_dir}/go/bin $PATH' >> #{home_dir}/.config/fish/config.fish"
  not_if "grep 'set -x PATH #{home_dir}/go/bin $PATH' #{home_dir}/.config/fish/config.fish"
end

file "#{home_dir}/go.tar.gz" do
  action :delete
end
