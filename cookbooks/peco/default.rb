package 'peco'

execute 'set alias' do
  command %[echo 'alias gmv="cd (ghq root)/(ghq list | peco)"' >> /home/#{node.user.name}/.config/fish/config.fish]
  not_if "grep 'alias gmv' /home/#{node.user.name}/.config/fish/config.fish"
end
