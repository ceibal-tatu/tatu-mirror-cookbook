#
# Cookbook Name:: tatu-mirror
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

cookbook_file '/etc/ssh/sshd_config' do
    source 'sshd_config'
    owner 'root'
    group 'root'
    mode '644'
    notifies :reload, 'service[ssh]'
end

service 'ssh' do 
    action [:enable, :start]
end

cookbook_file '/root/.ssh/authorized_keys' do
    source 'ssh_authorized_keys'
    owner 'root'
    group 'root'
    mode '600'
end

cookbook_file '/etc/apt/sources.list.d/tatu.list' do
    source 'tatu.list'
    owner 'root'
    group 'root'
    mode '644'
end

execute 'wget tatu.gpg.key' do
    command 'wget http://tatumaster.ddns.net/tatu.gpg.key -O - |apt-key add -'
end

package 'tatu-repo-devel'

cookbook_file '/etc/cron.d/tatu-rsync-mirror' do
    source 'tatu-rsync-mirror'
    owner 'root'
    group 'root'
    mode '644'
end
