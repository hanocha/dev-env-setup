# AWS CLI v2 と Session Manager plugin を公式配布物から導入する
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html

aws_bin = "/usr/local/bin/aws"
work_dir = "/tmp/awscli-install"

sm_plugin_url = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm"
sm_work_dir = "/tmp/session-manager-plugin-install"

dnf_package 'unzip'

execute "Install AWS CLI v2" do
  command <<~EOC
    rm -rf #{work_dir}
    mkdir -p #{work_dir}
    curl -fsSL --retry 3 https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o #{work_dir}/awscliv2.zip
    unzip -q #{work_dir}/awscliv2.zip -d #{work_dir}
    #{work_dir}/aws/install --update
    rm -rf #{work_dir}
  EOC
end

# AWS CLI の `aws ssm start-session` などで必要になるプラグイン。
# 最新版を入れるため、導入済みでも毎回 dnf に渡す（同バージョンなら何もしない）。
execute "Install Session Manager plugin" do
  command <<~EOC
    rm -rf #{sm_work_dir}
    mkdir -p #{sm_work_dir}
    curl -fsSL --retry 3 #{sm_plugin_url} -o #{sm_work_dir}/session-manager-plugin.rpm
    dnf install -y #{sm_work_dir}/session-manager-plugin.rpm
    rm -rf #{sm_work_dir}
  EOC
end
