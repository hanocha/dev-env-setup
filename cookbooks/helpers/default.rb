# mitamae の package リソースは RHEL 系で yum を呼ぶが、
# AlmaLinux 10 には yum 互換コマンドが無いことがあるため dnf を直接使う。

define :dnf_package do
  pkg = params[:name]

  execute "Install package #{pkg}" do
    command "dnf install -y #{pkg}"
    not_if "rpm -q #{pkg}"
  end
end
