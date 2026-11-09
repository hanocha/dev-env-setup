brew_bin = "/home/linuxbrew/.linuxbrew/bin/brew"
config_file_path = "/home/#{node.user.name}/.config/fish/config.fish"

execute "Install brew" do
  user node.user.name
  command "NONINTERACTIVE=1 /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  not_if "test -x #{brew_bin}"
end

execute "Add brew shellenv to config.fish" do
  user node.user.name
  command <<~EOC
    mkdir -p /home/#{node.user.name}/.config/fish
    touch #{config_file_path}
    echo 'eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)' >> #{config_file_path}
  EOC
  not_if "grep -q 'brew shellenv' #{config_file_path}"
end
