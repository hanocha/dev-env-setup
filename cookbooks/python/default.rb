git 'pyenv' do
  user node.user.name
  repository "https://github.com/pyenv/pyenv.git"
  destination "/home/#{node.user.name}/.pyenv"
end

execute 'add pyenv settings into config.fish' do
  user node.user.name
  command <<-COMMAND
    echo 'set -x PYENV_ROOT /home/#{node.user.name}/.pyenv' >> /home/#{node.user.name}/.config/fish/config.fish
    echo 'set -x PATH $PYENV_ROOT/bin $PATH' >> /home/#{node.user.name}/.config/fish/config.fish
    echo 'status --is-interactive; and . (pyenv init - | psub)' >> /home/#{node.user.name}/.config/fish/config.fish
COMMAND
  not_if "grep 'pyenv init' /home/#{node.user.name}/.config/fish/config.fish"
end
