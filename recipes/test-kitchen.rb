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

node.default['rbenv']['group_users'] = node['jenkins']['server']['user']

kitchen_critical_recipes = [
  "rbenv",
  "rbenv::ruby_build"
]

#Run critical recipes
kitchen_critical_recipes.each do | recipe |
  include_recipe recipe
end

#Set up rbenv ruby version and install the needed gems
ruby_version = "1.9.3-p448"
rbenv_ruby ruby_version

# test-kitchen must currently be installed as a "--pre" since it's not released yet
#rbenv_gem "test-kitchen" do
#	ruby_version ruby_version
#	options { "0" => "--pre"}
#end

#ruby_gems = [
#  "kitchen-openstack",
#  "berkshelf",
#  "foodcritic",
#  "vagrant"
#]

#ruby_gems.each do | my_gem |
#  rbenv_gem my_gem do
#	ruby_version ruby_version
#  end
end
