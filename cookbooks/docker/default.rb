package 'apt-transport-https'
package 'ca-certificates'
package 'curl'
package 'software-properties-common'

execute 'add apt-key of docker repo' do
  command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
  not_if 'apt-key fingerprint 0EBFCD88'
end

execute 'add apt repository' do
  command "add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable test edge'"
  not_if 'cat /etc/apt/sources.list | grep docker'
end

package 'docker-ce'
