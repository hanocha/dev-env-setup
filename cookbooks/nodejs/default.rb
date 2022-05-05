execute 'Install volta' do
  user node.user.name
  command 'fish -c "curl https://get.volta.sh | bash"'
end
