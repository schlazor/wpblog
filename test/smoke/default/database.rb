# # encoding: utf-8

# Inspec test for recipe wpblog::database

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(3306) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('processes') { should include 'mysqld' }
  its('addresses') do
    should include '127.0.0.1'
    should_not include '0.0.0.0'
  end
end

describe mysql_conf('/etc/mysql-wpdb/conf.d/wpdb.cnf') do
  its('query-cache-type') { should eq '1' }
  its('query-cache-limit') { should eq '1M' }
  its('query-cache-size') { should eq '16M' }
  its('default-storage-engine') { should eq 'InnoDB' }
  its('key-buffer-size') { should eq '32M' }
  its('myisam-recover') { should eq 'FORCE,BACKUP' }
  its('max-allowed-packet') { should eq '16M' }
  its('max-connect-errors') { should eq '1000000' }
  its('log-bin') { should eq '/var/lib/mysql-wpdb/mysql-bin' }
  its('expire-logs-days') { should eq '14' }
  its('sync-binlog') { should eq '1' }
  its('tmp-table-size') { should eq '32M' }
  its('max-heap-table-size') { should eq '32M' }
  its('max-connections') { should eq '500' }
  its('thread-cache-size') { should eq '50' }
  its('open-files-limit') { should eq '65535' }
  its('table-definition-cache') { should eq '1024' }
  its('table-open-cache') { should eq '2048' }
  its('innodb-flush-method') { should eq 'O_DIRECT' }
  its('innodb-log-files-in-group') { should eq '2' }
  its('innodb-log-file-size') { should eq '64M' }
  its('innodb-flush-log-at-trx-commit') { should eq '1' }
  its('innodb-file-per-table') { should eq '1' }
  its('innodb-buffer-pool-size') { should eq '160M' }
  its('log-error') { should eq '/var/lib/mysql-wpdb/mysql-error.log' }
  its('log-queries-not-using-indexes') { should eq '1' }
  its('slow-query-log') { should eq '1' }
  its('slow-query-log-file') { should eq '/var/lib/mysql-wpdb/mysql-slow.log' }
end
