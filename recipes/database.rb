#
# Cookbook:: wpblog
# Recipe:: database
#
# Copyright:: 2017, David Schlenk
#
# Much inspiration from the community wordpress cookbook:
# https://github.com/brint/wordpress-cookbook
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
include_recipe 'selinux::disabled'
include_recipe 'yum-mysql-community::mysql57'
Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)
node.normal_unless['wpblog']['mysql']['root_pw'] = random_password
node.normal_unless['wpblog']['mysql']['wpuser_pw'] = random_password
node.save unless Chef::Config[:solo]
db = node['wpblog']['mysql']
mysql_service db['instance_name'] do
  port db['port']
  version db['version']
  initial_root_password db['root_pw']
  bind_address db['bind_address']
  action [:create, :start]
end
mysql_config db['instance_name'] do
  instance db['instance_name']
  source "#{db['instance_name']}_settings.erb"
  notifies :restart, "mysql_service[#{db['instance_name']}]"
  action :create
end
mysql_client 'default' do
  version db['version']
end
mysql2_chef_gem 'default'
con = {
  host: 'localhost',
  username: 'root',
  password: db['root_pw'],
  socket: "/var/run/mysql-#{db['instance_name']}/mysqld.sock",
}
mysql_database db['instance_name'] do
  connection con
  action :create
end
mysql_database_user db['wpuser'] do
  connection con
  password db['wpuser_pw']
  database_name db['instance_name']
  action :create
end
mysql_database_user db['wpuser'] do
  connection con
  password db['wpuser_pw']
  database_name db['instance_name']
  privileges [:all]
  action :grant
end
