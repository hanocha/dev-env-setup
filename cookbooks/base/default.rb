# AlmaLinux 10 / RHEL 10 (el10) 向けの前提パッケージとリポジトリ
#
# - CRB は AlmaLinux 10 ではデフォルト有効だが、無効化されている環境向けに明示する
# - fish などは EPEL 10 経由

execute "Require Enterprise Linux 10" do
  command <<~'EOC'
    grep -E 'PLATFORM_ID="platform:el10"|VERSION_ID="10(\.|")' /etc/os-release >/dev/null
  EOC
end

dnf_package 'dnf-plugins-core'

execute "Enable CRB repository" do
  command "dnf config-manager --set-enabled crb"
  not_if "dnf repolist --enabled | awk '{print $1}' | grep -qx crb"
end

dnf_package 'epel-release'

execute "Install Development Tools" do
  command "dnf group install -y 'Development Tools'"
  not_if "rpm -q gcc >/dev/null 2>&1"
end

# Homebrew on Linux (RHEL/Alma) の公式依存
%w[
  procps-ng
  curl
  file
  git
].each do |pkg|
  dnf_package pkg
end
