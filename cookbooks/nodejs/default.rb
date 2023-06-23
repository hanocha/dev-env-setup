execute 'Install volta' do
  command 'fish -c "curl https://get.volta.sh | bash"'
  user node.user.name
  not_if "which volta"
end
