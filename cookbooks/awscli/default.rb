# AWS CLI v2 を公式インストーラーで導入する（/usr/local/bin/aws）
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

aws_bin = "/usr/local/bin/aws"
work_dir = "/tmp/awscli-install"

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
