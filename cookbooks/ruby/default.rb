git "rbenv" do
  user node.user.name
  repository "https://github.com/rbenv/rbenv.git"
  destination "/home/#{node.user.name}/.rbenv"
  not_if "test -e /home/#{node.user.name}/.rbenv"
end

execute 'Add rbenv settings into config.fish' do
  user node.user.name
  command <<~COMMAND
    echo 'status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source' >> /home/#{node.user.name}/.config/fish/config.fish
  COMMAND
  not_if "grep '~/.rbenv/bin/rbenv init' /home/#{node.user.name}/.config/fish/config.fish"
end

directory "/home/#{node.user.name}/.rbenv/plugins" do
  action :create
end

git "ruby-build" do
  repository "https://github.com/rbenv/ruby-build.git"
  destination "/home/#{node.user.name}/.rbenv/plugins/ruby-build"
  not_if "test -e /home/#{node.user.name}/.rbenv/plugins/ruby-build"
end

%w(autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev).each do |pkg|
  package pkg
end
