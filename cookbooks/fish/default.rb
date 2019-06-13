execute "Add fish shell repository" do
  command "apt-add-repository ppa:fish-shell/release-2"
  not_if "ls /etc/apt/sources.list.d/ | grep 'fish-shell-ubuntu-release-2'"
end

package "fish"

config_file_path = "/home/#{node.user.name}/.config/fish/config.fish"

file "Create fish config file" do
  path config_file_path
  owner node.user.name
  group node.user.name
end

execute "set default shell to fish" do
  command "chsh -s /usr/bin/fish #{node.user.name}"
  not_if "cat /etc/passwd | grep '/home/#{node.user.name}:/usr/bin/fish'"
end

execute "Install fisherman" do
  user node.user.name
  command "curl -Lo /home/#{node.user.name}/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher"
  not_if "ls /home/#{node.user.name}/.config/fish/functions/fisher.fish"
end

execute "Install bobthefish" do
  user node.user.name
  cwd "/home/#{node.user.name}"
  command "fish -c 'fisher add oh-my-fish/theme-bobthefish'"
  not_if "ls /home/hanocha/.config/fisherman/bobthefish/"
end

execute "Add aliases into config.fish" do
  user node.user.name
  cwd "/home/#{node.user.name}"
  command <<-EOC
echo "alias gco='git checkout'" >> #{config_file_path}
echo "alias be='bundle exec'" >> #{config_file_path}
  EOC
  not_if "cat #{config_file_path} | grep 'alias gco'"
end
