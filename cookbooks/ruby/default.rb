git "rbenv" do
  user node.user.name
  repository "https://github.com/rbenv/rbenv.git"
  destination "/home/#{node.user.name}/.rbenv"
end

execute 'Add rbenv settings into config.fish' do
  user node.user.name
  command <<~COMMAND
    echo 'set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths' >> /home/#{node.user.name}/.config/fish/config.fish
    echo 'status --is-interactive; and rbenv init - fish | source' >> /home/#{node.user.name}/.config/fish/config.fish
  COMMAND
  not_if "cat /home/#{node.user.name}/.config/fish/config.fish | grep fish_user_paths"
end

directory "/home/#{node.user.name}/.rbenv/plugins" do
  action :create
end

git "ruby-build" do
  repository "https://github.com/rbenv/ruby-build.git"
  destination "/home/#{node.user.name}/.rbenv/plugins/ruby-build"
end
