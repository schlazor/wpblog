name 'wpblog'
maintainer 'David Schlenk'
maintainer_email 'do@schdav.org'
license 'apache2'
description 'Install/configure a wordpress blog'
long_description 'Install wordpress with modern php and mysql on CentOS 7'
version '0.1.0'

supports 'centos'
supports 'rhel'

issues_url 'https://github.com/schlazor/wpblog/issues' if respond_to?(:issues_url)

source_url 'https://github.com/schlazor/wpblog' if respond_to?(:source_url)

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
