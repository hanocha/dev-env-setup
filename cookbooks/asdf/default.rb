brew_bin = "/home/linuxbrew/.linuxbrew/bin/brew"
asdf_bin = "/home/linuxbrew/.linuxbrew/bin/asdf"
config_file_path = "/home/#{node.user.name}/.config/fish/config.fish"
completion_dir = "/home/#{node.user.name}/.config/fish/completions"
completion_path = "#{completion_dir}/asdf.fish"

# ghq / neovim と同様に Homebrew 経由で導入する（asdf 0.16 以降の Go 実装）。
# バージョンを上げたい場合は手動で `brew upgrade asdf` を実行する。
execute "install asdf by brew" do
  user node.user.name
  command "#{brew_bin} install asdf"
  not_if "test -x #{asdf_bin}"
end

# asdf 0.16 以降はシェルスクリプトの source が不要で、shims を PATH に追加する。
# https://asdf-vm.com/guide/getting-started.html#_2-configure-asdf
execute "Add asdf shims to config.fish" do
  user node.user.name
  command <<~EOC
    cat >> #{config_file_path} <<'FISH'
    # ASDF configuration code
    if test -z $ASDF_DATA_DIR
        set _asdf_shims "$HOME/.asdf/shims"
    else
        set _asdf_shims "$ASDF_DATA_DIR/shims"
    end

    # Do not use fish_add_path (added in Fish 3.2) because it
    # potentially changes the order of items in PATH
    if not contains $_asdf_shims $PATH
        set -gx --prepend PATH $_asdf_shims
    end
    set --erase _asdf_shims
    FISH
  EOC
  not_if "grep -q '# ASDF configuration code' #{config_file_path}"
end

directory completion_dir do
  owner node.user.name
  group node.user.name
end

execute "Generate asdf fish completions" do
  user node.user.name
  command "#{asdf_bin} completion fish > #{completion_path}"
  not_if "test -s #{completion_path}"
end
