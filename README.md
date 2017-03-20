# wpblog Cookbook

Installs and configures MySQL 5.7, nginx, php 7.1 (with fpm) and latest wordpress on CentOS 7.x.

## Requirements

### Platforms
- CentOS 7.x

### Chef
- Chef 12.1+

### Cookbooks

```
depends 'yum-ius'
depends 'mysql'
depends 'yum-mysql-community'
depends 'openssl'
depends 'line'
depends 'chef_nginx'
depends 'selinux'
depends 'database'
depends 'tar'
depends 'mysql2_chef_gem'
```
No version pins have been required (yet) so I'll keep it that way until something breaks.

## Recipes

### default

Includes all the other recipes in the proper order, downloads & extracts wordpress, and then templates wp-config.php. 

### database

Installs MySQL 5.7 using the `mysql`, `yum_mysql_community`, `mysql2_chef_gem` cookbooks. Creates a database and user for wordpress. Attempts to optimize the config according to Percona's config wizard thing and a random blog that said to turn on some query caching. 

### web

Installs nginx via the `chef_nginx` cookbook. Disables default site. Removes default site file. Configures `wordpress` site just enough to make it functional, based heavily on the template used in the `wordpress` cookbook's `nginx` recipe. 

### php

Installs PHP 7.1 from the IUS repo via the `yum-ius` cookbook. Also installs and starts the `php-fpm` service, listening only on a unix socket. Configures nginx to talk to said unix socket for php-fpm.

### wpcreds

Immutably creates random passwords and salts for use by the wordpress installer.

## Usage

Include this on a CentOS 7.x node's run list to get wordpress installed using MySQL 5.7, nginx and PHP 5.7. You will still need to run through the actual installer and upgrades are on you, but this'll get you started. Might I recommend you also utilize some security cookbooks in your run list, such as: 

- [os-hardening](https://github.com/dev-sec/chef-os-hardening)
- [nginx-hardening](https://github.com/dev-sec/chef-nginx-hardening)
- [ssh-hardening](https://github.com/dev-sec/chef-ssh-hardening)
- [fail2ban](https://github.com/chef-cookbooks/fail2ban)

## Attributes

You can read the default attributes file as well as I can copy and paste it in here.

## License and Author

The [wordpress cookbook](https://github.com/brint/wordpress-cookbook) was an invaluable resource. I hope to abandon this cookbook in the future once it and the various PHP cookbooks have better (any?) support for CentOS 7 and non-RHEL PHP.

```
Author:: David Schlenk (<david@schdav.org>)

Copyright:: 2017, David Schlenk

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
