execute 'install oh-my-zsh' do
  user node.user.name
  cwd "/home/#{node.user.name}"
  command %|sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"|
end
