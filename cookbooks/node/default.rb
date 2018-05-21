execute 'download nodebrew' do
  user 'hanocha'
  cwd '/home/hanocha'
  command 'curl -L git.io/nodebrew | perl - setup'
end

execute 'add path of nodebrew' do
  user 'hanocha'
  command 'echo "export PATH=$HOME/.nodebrew/current/bin:$PATH" > /home/hanocha/.bashrc'
  not_if 'nodebrew help'
end

execute 'install node' do
  command '/home/hanocha/.nodebrew/current/bin/nodebrew install 8.11.2'
end
