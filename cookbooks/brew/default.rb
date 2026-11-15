brew_prefix = "/home/linuxbrew/.linuxbrew"
brew_bin = "#{brew_prefix}/bin/brew"
config_file_path = "/home/#{node.user.name}/.config/fish/config.fish"
user_name = node.user.name

directory "/home/linuxbrew" do
  owner user_name
  group user_name
  mode "0755"
end

directory brew_prefix do
  owner user_name
  group user_name
  mode "0755"
end


execute "Install brew" do
  user user_name
  command "NONINTERACTIVE=1 HOMEBREW_NO_SUDO=1 /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  not_if "test -x #{brew_bin}"
end

execute "Add brew shellenv to config.fish" do
  user user_name
  command <<~EOC
    mkdir -p /home/#{node.user.name}/.config/fish
    touch #{config_file_path}
    echo 'eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)' >> #{config_file_path}
  EOC
  not_if "grep -q 'brew shellenv' #{config_file_path}"
end
