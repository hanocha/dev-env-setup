execute "Add fish shell repository" do
  command <<EOS
    apt-add-repository ppa:fish-shell/release-2
    apt-get update
EOS
end

package "fish"

execute "set default shell to fish" do
  command "chsh -s /usr/bin/fish #{node.user.name}"
end

execute "Install fisherman" do
  user node.user.name
  command "curl -Lo /home/#{node.user.name}/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher"
end

execute "Install some plugins" do
  user node.user.name
  cwd "/home/#{node.user.name}"
  command "fish -c 'fisher oh-my-fish/theme-bobthefish'"
end
