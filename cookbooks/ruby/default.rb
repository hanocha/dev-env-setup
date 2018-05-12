package "make"
package "gcc"
package "g++"
package "openssl"
package "libssl-dev"
package "zlib1g-dev"
package "libreadline-dev"

git "rbenv" do
  user node.user.name
  repository "https://github.com/rbenv/rbenv.git"
  destination "/home/#{node.user.name}/.rbenv"
end

git "ruby-build" do
  user node.user.name
  repository "https://github.com/rbenv/ruby-build.git"
  destination "/home/#{node.user.name}/.rbenv/plugins/ruby-build"
end

execute "init rbenv" do
  user node.user.name
  command "/home/#{node.user.name}/.rbenv/bin/rbenv init -"
  not_if "/home/#{node.user.name}/.rbenv/bin/rbenv -v"
end

directory "/home/#{node.user.name}/.rbenv/shims" do
  owner node.user.name
  group node.user.name
  action :create
end

directory "/home/#{node.user.name}/.rbenv/versions" do
  owner node.user.name
  group node.user.name
  action :create
end

execute "add rbenv settings" do
  command %|
    echo 'set -x RBENV_ROOT /home/#{node.user.name}/.rbenv' >> /home/#{node.user.name}/.config/fish/config.fish
    echo 'set -x PATH $RBENV_ROOT/bin $PATH' >> /home/#{node.user.name}/.config/fish/config.fish
    echo 'set -x PATH $RBENV_ROOT/shims $PATH' >> /home/#{node.user.name}/.config/fish/config.fish
    echo 'eval (rbenv init -)' >> /home/#{node.user.name}/.config/fish/config.fish
|
  not_if "grep 'eval (rbenv init -)' /home/#{node.user.name}/.config/fish/config.fish"
end

execute "install ruby 2.5.0" do
  user node.user.name
  command "/home/#{node.user.name}/.rbenv/bin/rbenv install 2.5.0"
  not_if "/home/#{node.user.name}/.rbenv/bin/rbenv versions | grep 2.5.0"
end
