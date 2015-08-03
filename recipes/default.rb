#
# Cookbook Name:: docker001
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.




include_recipe 'apt::default'

# Install and configures docker
docker_service 'default' do
  action [:create, :start]
end

# For centos
if node.attribute?("centos")
	docker_image "chef/centos-#{node['centos']['version']}" do
        	action :pull
	end

	$c = node['centos']['count']
	for i in 1..$c
        	docker_container "chef/centos-#{node['centos']['version']}-#{i}" do
                	detach true
                	container_name "centos_container_#{i}"
                	command "/bin/echo centos_container_#{i}"
			image "chef/centos-#{node['centos']['version']}"
	        	port "520#{i}:520#{i}"
	        	env 'SETTINGS_FLAVOR=local'
	        	volume "/mnt/docker:/docker-storage22#{i}"
        	end
	end
end

# For ubuntu
if node.attribute?("ubuntu")
        docker_image "chef/ubuntu-#{node['ubuntu']['version']}" do
		action :pull
	end

	$u = node['ubuntu']['count']
	for i in 1..$u
		docker_container "chef/ubuntu-#{node['ubuntu']['version']}-#{i}" do
			detach true
			container_name "ubuntu_container_#{i}"
			command "/bin/echo ubuntu_container_#{i}"
			image "chef/ubuntu-#{node['ubuntu']['version']}"
			port "500#{i}:500#{i}"
			env 'SETTINGS_FLAVOR=local'
			volume "/mnt/docker:/docker-storage#{i}"
		end
	end
end

# For debian
if node.attribute?("debian")
        docker_image "chef/debian-#{node['debian']['version']}" do
		action :pull
	end

	$d = node['debian']['count']
	for i in 1..$d
		docker_container "chef/debian-#{node['debian']['version']}-#{i}" do
		        detach true
		        container_name "debian_container_#{i}"
		        command "/bin/echo debian_container_#{i}"
			image "chef/debian-#{node['debian']['version']}"
		        port "510#{i}:510#{i}"
		        env 'SETTINGS_FLAVOR=local'
		        volume "/mnt/docker:/docker-storage9#{i}"
		end
	end
end
