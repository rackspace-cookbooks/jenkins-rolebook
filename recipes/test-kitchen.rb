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

#Set up rbenv ruby version and install the needed gems
my_ruby_version = "1.9.3-p448"
rbenv_ruby my_ruby_version

# test-kitchen must currently be installed as a "--pre" since it's not released yet
# this is not working currently due to the options
#rbenv_gem "test-kitchen" do
#	ruby_version ruby_version
#	options {["opts" => "pre"]}
#end

ruby_gems = [
  "kitchen-openstack",
  "berkshelf",
  "foodcritic"
]

ruby_gems.each do | my_gem |
  rbenv_gem my_gem do
	ruby_version my_ruby_version
  end
end

group "rbenv" do
	members ["#{node['jenkins']['server']['user']}"]
	action :manage
end

rbenv_execute "activate rbenv local 1.9.3-p448" do
	command "rbenv local 1.9.3-p448"
	cwd "#{node['jenkins']['server']['home']}"
	creates "#{node['jenkins']['server']['home']}.ruby-version"
	user node['jenkins']['server']['user']
	group node['jenkins']['server']['user']
	ruby_version my_ruby_version
end