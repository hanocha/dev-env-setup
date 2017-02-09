Specinfra::Command::Linuxmint = Class.new
Specinfra::Command::Linuxmint::Base = Class.new(Specinfra::Command::Debian::Base)
Specinfra::Command::Linuxmint::Base::Ppa = Class.new(Specinfra::Command::Debian::Base::Ppa)
Specinfra::Command::Linuxmint::Base::Service = Class.new(Specinfra::Command::Debian::Base::Service)

include_recipe "./cookbooks/vim/default.rb"
