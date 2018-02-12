execute "Add fish shell repository" do
  command <<EOS
    apt-add-repository ppa:fish-shell/release-2
    apt-get update
EOS
end

package "fish"
