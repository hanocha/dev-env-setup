package "neovim"

execute 'set default editor to vim' do
  command %|echo 'set -x EDITOR vim' >> /home/#{node.user.name}/.config/fish/config.fish|
  not_if "grep 'set -x EDITOR' /home/#{node.user.name}/.config/fish/config.fish"
end
