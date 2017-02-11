Specinfra::Command::Linuxmint = Class.new
Specinfra::Command::Linuxmint::Base = Class.new(Specinfra::Command::Debian::Base)
Specinfra::Command::Linuxmint::Base::Ppa = Class.new(Specinfra::Command::Debian::Base::Ppa)
Specinfra::Command::Linuxmint::Base::Service = Class.new(Specinfra::Command::Debian::Base::Service)

include_recipe "./cookbooks/vim/default.rb"
include_recipe "./cookbooks/zsh/default.rb"
include_recipe "./cookbooks/oh-my-zsh/default.rb"
include_recipe "./cookbooks/tmux/default.rb"
include_recipe "./cookbooks/ruby/default.rb"
include_recipe './cookbooks/go/default.rb'
include_recipe './cookbooks/ghq/default.rb'
include_recipe './cookbooks/peco/default.rb'
