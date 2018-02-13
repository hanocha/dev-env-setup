execute "Add fish shell repository" do
  command "apt-add-repository ppa:fish-shell/release-2"
  not_if "ls /etc/apt/sources.list.d/ | grep 'fish-shell-ubuntu-release-2'"
end

package "fish"

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
  command "fish -c 'fisher oh-my-fish/theme-bobthefish'"
  not_if "ls /home/hanocha/.config/fisherman/bobthefish/"
end
