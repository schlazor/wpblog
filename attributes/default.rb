default['wpblog']['mysql']['instance_name'] = 'wpdb'
default['wpblog']['mysql']['port'] = '3306'
default['wpblog']['mysql']['version'] = '5.7'
default['wpblog']['mysql']['prefix'] = 'wp_'
default['wpblog']['mysql']['charset'] = 'utf8'
default['wpblog']['mysql']['collate'] = ''
default['wpblog']['mysql']['wpuser'] = 'wpuser'
default['wpblog']['mysql']['bind_address'] = '127.0.0.1'
default['wpblog']['mysql']['query_cache_type'] = 1
default['wpblog']['mysql']['query_cache_limit'] = '1M'
default['wpblog']['mysql']['query_cache_size'] = '16M'
default['wpblog']['mysql']['default_storage_engine'] = 'InnoDB'
default['wpblog']['mysql']['key_buffer_size'] = '32M'
default['wpblog']['mysql']['myisam_recover'] = 'FORCE,BACKUP'
default['wpblog']['mysql']['max_allowed_packet'] = '16M'
default['wpblog']['mysql']['max_connect_errors'] = 1000000
default['wpblog']['mysql']['log_bin'] = '/var/lib/mysql-wpdb/mysql-bin'
default['wpblog']['mysql']['expire_logs_days'] = 14
default['wpblog']['mysql']['sync_binlog'] = 1
default['wpblog']['mysql']['tmp_table_size'] = '32M'
default['wpblog']['mysql']['max_heap_table_size'] = '32M'
default['wpblog']['mysql']['max_connections'] = 500
default['wpblog']['mysql']['thread_cache_size'] = 50
default['wpblog']['mysql']['open_files_limit'] = 65535
default['wpblog']['mysql']['table_definition_cache'] = 1024
default['wpblog']['mysql']['table_open_cache'] = 2048
default['wpblog']['mysql']['innodb_flush_method'] = 'O_DIRECT'
default['wpblog']['mysql']['innodb_log_files_in_group'] = 2
default['wpblog']['mysql']['innodb_log_file_size'] = '64M'
default['wpblog']['mysql']['innodb_flush_log_at_trx_commit'] = 1
default['wpblog']['mysql']['innodb_file_per_table'] = 1
default['wpblog']['mysql']['innodb_buffer_pool_size'] = '160M'
default['wpblog']['mysql']['log_error'] = '/var/lib/mysql-wpdb/mysql-error.log'
default['wpblog']['mysql']['log_queries_not_using_indexes'] = 1
default['wpblog']['mysql']['slow_query_log'] = 1
default['wpblog']['mysql']['slow_query_log_file'] = '/var/lib/mysql-wpdb/mysql-slow.log'
default['wpblog']['dir'] = '/var/www/wordpress'
default['wpblog']['wp_config_options'] = {}
default['nginx']['default_site_enabled'] = false
