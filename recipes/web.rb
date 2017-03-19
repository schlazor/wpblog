#
# Cookbook:: wpblog
# Recipe:: web
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
include_recipe 'chef_nginx'
nginx_site 'wordpress' do
  template 'nginx-default.erb'
  variables(
    server_port: 80,
    server_name: node['fqdn'],
    server_aliases: [],
    docroot: '/var/www/wordpress'
  )
  notifies :restart, 'service[nginx]'
end
file File.join(node['nginx']['dir'], 'conf.d', 'default.conf') do
  action :delete
  notifies :reload, 'service[nginx]'
  only_if { node['platform_family'] == 'rhel' && !node['nginx']['default_site_enabled'] }
end
