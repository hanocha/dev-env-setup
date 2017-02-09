package 'zsh'

execute 'change default shell to zsh' do
  command "chsh -s /bin/zsh #{node.user.name}"
end
