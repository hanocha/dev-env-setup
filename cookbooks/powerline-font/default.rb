git "clone powerline/fonts repo" do
  user node.user.name
  repository "git@github.com:powerline/fonts.git"
  destination "/home/#{node.user.name}/fonts"
  not_if "fc-list | grep 'Source Code Pro Powerline'"
end

execute "Install fonts" do
  user node.user.name
  cwd "/home/#{node.user.name}/fonts"
  command "./install.sh"
  not_if "fc-list | grep 'Source Code Pro Powerline'"
end
