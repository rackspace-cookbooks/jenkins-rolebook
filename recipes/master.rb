#
# Author:: Ryan Richard (ryan.richard@rackspace.com)
# Cookbook Name:: jenkins-rolebook
# Recipe:: default
#
# Copyright 2013, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#jenkins settings
node.default['jenkins']['server']['install_method'] = "war"
node.default['jenkins']['http_proxy']['www_redirect'] = "enable"
node.default['jenkins']['server']['host'] = "jenkins.rackops.org"
node.default['jenkins']['http_proxy']['host_name'] = "jenkins.rackops.org"
node.default['jenkins']['server']['version'] = "1.533"

node.default['jenkins']['server']['plugins'] = [
	'git',
	'github',
	'ghprb',
	'github-api',
	'rundeck',
	'jobConfigHistory',
	'global-build-stats',
	'envinject'
]

node.default['nginx']['default_site_enabled'] = false

user "#{node['jenkins']['server']['user']}" do
	shell "/bin/bash"
	action :manage
end

#postfix settings
node.default['postfix']['main']['myhostname'] = "jenkins.rackops.org"

#backups
node.default['rackspace_cloud_backup']['backup_locations']  = ["/var/lib/jenkins"]
node.default['rackspace_cloud_backup']['rackspace_endpoint'] = "ord"
node.default['rackspace_cloud_backup']['backup_container'] = "jenkins-turbolift"

#nice to have packages
package "tig" do
	action :install
end

#install github upstream merge script
git "/var/lib/jenkins/jenkins-upstream-merge" do
  repository "git@github.com/rackops/jenkins-upstream-merge"
  revision "master"
  user "jenkins"
  group "jenkins"
  action :sync
end

