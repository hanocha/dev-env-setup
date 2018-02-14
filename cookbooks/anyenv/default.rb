git "anyenv" do
  user node.user.name
  repository "https://github.com/riywo/anyenv"
  destination "/home/#{node.user.name}/.anyenv"
end

execute "Add settings for anyenv" do
  command %|
    echo 'set -x PATH $HOME/.anyenv/bin $PATH' >> /home/#{node.user.name}/.config/fish/config.fish
|
  not_if "cat /home/#{node.user.name}/.config/fish/config.fish | grep 'set -x PATH $RBENV_ROOT/shims $PATH'"
end
