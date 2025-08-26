execute "Install brew" do
  user node.user.name
  command "NONINTERACTIVE=1 curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash"
  not_if "which brew"
end
