package 'gcc'
package 'openssl'
package 'libssl-dev'
package 'zlib1g-dev'
package 'libreadline-dev'

git 'rbenv' do
  user node.user.name
  repository 'https://github.com/rbenv/rbenv.git'
  destination '/home/hanocha/.rbenv'
end

git 'ruby-build' do
  user node.user.name
  repository 'https://github.com/rbenv/ruby-build.git'
  destination '/home/hanocha/.rbenv/plugins/ruby-build'
end

execute 'init rbenv' do
  user node.user.name
  command '/home/hanocha/.rbenv/bin/rbenv init -'
  not_if '/home/hanocha/.rbenv/bin/rbenv -v'
end

directory '/home/hanocha/.rbenv/shims' do
  action :create
end

directory '/home/hanocha/.rbenv/versions' do
  action :create
end

execute 'add rbenv settings into /home/hanocha/.zshrc' do
  command %|echo 'export RBENV_ROOT="/home/hanocha/.rbenv"' >> /home/hanocha/.zshrc
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/hanocha/.zshrc
echo 'eval "$(rbenv init -)"' >> /home/hanocha/.zshrc
|
  not_if 'grep "RBENV_ROOT" /home/hanocha/.zshrc'
end

execute "install ruby 2.4.0" do
  user node.user.name
  command "/home/hanocha/.rbenv/bin/rbenv install 2.4.0"
  not_if '/home/hanocha/.rbenv/bin/rbenv versions | grep 2.4.0'
end
