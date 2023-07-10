execute 'Set user.email and user.name' do
  user node.user.name
  command "git config --global user.email #{node.git.email}; git config --global user.name #{node.git.name}"
end
