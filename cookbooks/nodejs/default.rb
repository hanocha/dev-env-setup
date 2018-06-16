execute 'download and setup nodebrew' do
  user node.user.name
  command 'curl -L git.io/nodebrew | perl - setup'
  not_if "/home/#{node.user.name}/.nodebrew/current/bin/nodebrew"
end

execute "add nodebrew settings" do
  command %|
    echo 'set -x PATH /home/#{node.user.name}/.nodebrew/current/bin $PATH' >> /home/#{node.user.name}/.config/fish/config.fish
|
  not_if "grep '.nodebrew/current/bin' /home/#{node.user.name}/.config/fish/config.fish"
end

execute 'install nodejs(latest, stable)' do
  command "/home/#{node.user.name}/.nodebrew/current/bin/nodebrew install stable"
  not_if "/home/#{node.user.name}/.nodebrew/current/bin/node -v"
end
