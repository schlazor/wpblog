#
# Cookbook:: wpblog
# Recipe:: default
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

include_recipe 'wpblog::database'
include_recipe 'wpblog::web'
include_recipe 'wpblog::php'
include_recipe 'wpblog::wpcreds'

directory node['wpblog']['dir'] do
  action :create
  recursive true
  owner 'nginx'
  owner 'nginx'
  mode 00755
end

tar_extract 'https://wordpress.org/latest.tar.gz' do
  target_dir node['wpblog']['dir']
  creates File.join(node['wpblog']['dir'], 'index.php')
  user 'nginx'
  group 'nginx'
  tar_flags ['--strip-components 1']
  not_if { ::File.exist?("#{node['wpblog']['dir']}/index.php") }
end

db = node['wpblog']['mysql']
keys = node['wpblog']['keys']
salt = node['wpblog']['salt']
template "#{node['wpblog']['dir']}/wp-config.php" do
  source 'wp-config.php.erb'
  mode 00644
  variables(
    db_name: db['instance_name'],
    db_user: db['wpuser'],
    db_password: db['wpuser_pw'],
    db_host: db['bind_address'],
    db_prefix: db['prefix'],
    db_charset: db['charset'],
    db_collate: db['collate'],
    auth_key: keys['auth'],
    secure_auth_key: keys['secure_auth'],
    logged_in_key: keys['logged_in'],
    nonce_key: keys['nonce'],
    auth_salt: salt['auth'],
    secure_auth_salt: salt['secure_auth'],
    logged_in_salt: salt['logged_in'],
    nonce_salt: salt['nonce'],
    wp_config_options: node['wpblog']['wp_config_options']
  )
  owner 'nginx'
  group 'nginx'
  action :create
end
