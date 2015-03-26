
include_recipe 'apt'
include_recipe 'nfs'

%w{vim nfs-common nfs-kernel-server}.each do |pkg|
  package pkg do
    action [:install]
  end
end

directory "/home/ubuntu/share" do
  owner "ubuntu"
  group "ubuntu"
  mode "0755"
  action :create
end

nfs_export "/home/ubuntu/share" do
  network '10.14.100.0/24'
  writeable false
  sync true
  options ['no_root_squash']
end

service "nfs-kernel-server" do
  action :restart
end

remote_file "/home/ubuntu/share/toycomercial001.mp4" do
  source "https://archive.org/download/deluxemeninspace/toycomercial001.mp4"
  owner "ubuntu"
  group "ubuntu"
  mode "0644"
  action :create
end

# transmission_torrent_file "/home/ubuntu/ubuntu-server-14.04.iso"  do
#   torrent "http://releases.ubuntu.com/trusty/ubuntu-14.04.1-server-amd64.iso.torrent"
#   owner 'ubuntu'
#   group 'ubuntu'
#   rpc_username node['transmission']['rpc_username']
#   rpc_password node['transmission']['rpc_password']
#   action :create
# end
