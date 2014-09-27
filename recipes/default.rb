#
# Cookbook Name:: cryp7_users
# Recipe:: default
#
# Copyright (C) 2014 stefan schwoegler
#
# All rights reserved - Do Not Redistribute

# all concepts "borrowed" str8 from https://www.getchef.com/blog/2014/07/10/managing-users-and-ssh-keys-in-a-hybrid-world/

include_recipe 'sudo'

#############
# meta-RBAC #
#############

#first define the roles (via groups)
node['cryp7_users']['groups'].each do |group|
	users_manage group do
		action [ :remove, :create ]
	end
end

# then, define what users are allowed to execute as whom
# this is implemented using teh sudo cookbook and specified
# as an array in teh form of
# 0: group name
# 1: user to runas
# 2: ['array', 'of', 'commands']
#
# E.G. 	grant users in teh cryp7 group the ability to run
#	/bin/ls as root: ['cryp7','root',['/bin/ls']
#
# Further, if one were to add this to a specific chef node
#
#	{
#		"name": "node",
#		"chef_environment": "_default",
#		"normal": {
#			"tags": [],
#		"cryp7_users": {
#			sudo_tuples": [ ['cryp7','root',['/bin/ls']] ]
#			}
#		},
#		"runlist": [
#			"recipe[cryp7_users]"
#		]
#	}
#

node['cryp7_users']['sudo_tuples'].each do |tuple|
	sudo tuple[0] do
		group		tuple[0]
		runas		tuple[1]
		nopasswd	true
		commands	tuple[2]
	end
end unless node['cryp7_users']['sudo_tuples'].nil?

#e0f

