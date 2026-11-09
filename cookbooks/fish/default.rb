# fish は EPEL 10 経由（AlmaLinux 10 では fish 4.x）
dnf_package 'fish'

config_file_path = "/home/#{node.user.name}/.config/fish/config.fish"
fisher_path = "/home/#{node.user.name}/.config/fish/functions/fisher.fish"

directory "/home/#{node.user.name}/.config" do
  owner node.user.name
  group node.user.name
end

directory "/home/#{node.user.name}/.config/fish" do
  owner node.user.name
  group node.user.name
end

file "Create fish config file" do
  path config_file_path
  owner node.user.name
  group node.user.name
end

execute "Ensure fish is listed in /etc/shells" do
  command "grep -qx /usr/bin/fish /etc/shells || echo /usr/bin/fish >> /etc/shells"
  not_if "grep -qx /usr/bin/fish /etc/shells"
end

execute "set default shell to fish" do
  command "chsh -s /usr/bin/fish #{node.user.name}"
  not_if "grep -q '^#{node.user.name}:.*:/usr/bin/fish$' /etc/passwd"
end

# fisher 公式の導入手順（fish 4 対応）
execute "Install fisher" do
  user node.user.name
  cwd "/home/#{node.user.name}"
  command "fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'"
  not_if "test -f #{fisher_path}"
end

execute "Install bobthefish" do
  user node.user.name
  cwd "/home/#{node.user.name}"
  command "fish -c 'fisher install oh-my-fish/theme-bobthefish'"
  not_if "test -e /home/#{node.user.name}/.config/fish/functions/bobthefish_display_colors.fish"
end

# fish 4 でも有効な alias 記法
execute "Add aliases into config.fish" do
  user node.user.name
  cwd "/home/#{node.user.name}"
  command <<~EOC
    echo "alias gs 'git switch'" >> #{config_file_path}
    echo "alias dce 'docker compose exec'" >> #{config_file_path}
    echo "alias dcu 'docker compose up'" >> #{config_file_path}
  EOC
  not_if "grep -qE \"alias gs[= ]\" #{config_file_path}"
end
