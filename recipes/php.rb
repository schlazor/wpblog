#
# Cookbook:: wpblog
# Recipe:: php
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
include_recipe 'yum-ius'
package %w(mod_php php-fpm php-cli php-common httpd) do
  action :remove
end
include_recipe 'wpblog::web'
package %w(php71u-fpm-nginx php71u-cli php71u-mysqlnd)
service 'php-fpm' do
  action [:enable, :start]
  notifies :restart, 'service[nginx]'
end
replace_or_add 'make php-fpm listen on socket' do
  path '/etc/php-fpm.d/www.conf'
  pattern 'listen = 127.0.0.1:9000'
  line 'listen = /run/php-fpm/www.sock'
  notifies :restart, 'service[php-fpm]'
end
replace_or_add 'add nginx to acl_users' do
  path '/etc/php-fpm.d/www.conf'
  pattern ';listen.acl_users = nginx'
  line 'listen.acl_users = nginx'
  notifies :restart, 'service[php-fpm]'
end
replace_or_add 'tell nginx to use socket' do
  path '/etc/nginx/conf.d/php-fpm.conf'
  pattern 'server 127.0.0.1:9000;'
  line '        server unix:/run/php-fpm/www.sock;'
  notifies :restart, 'service[nginx]'
end
