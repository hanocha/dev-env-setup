git 'ndenv' do
  user node.user.name
  repository 'https://github.com/riywo/ndenv'
  destination '/home/hanocha/.ndenv'
end

git 'node-build' do
  user node.user.name
  repository 'https://github.com/riywo/node-build.git'
  destination '/home/hanocha/.ndenv/plugins/node-build'
end

execute 'add ndenv settings into /home/hanocha/.zshrc' do
  command %|echo 'export PATH="$HOME/.ndenv/bin:$PATH"' >> /home/hanocha/.zshrc
echo 'eval "$(ndenv init -)"' >> /home/hanocha/.zshrc
|
  not_if 'grep "ndenv" /home/hanocha/.zshrc'
end

execute "install node 6.10.2" do
  user node.user.name
  command "/home/hanocha/.ndenv/bin/ndenv install v6.10.2"
  not_if '/home/hanocha/.ndenv/bin/ndenv versions | grep v6.10.2'
end
