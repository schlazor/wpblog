# # encoding: utf-8

# Inspec test for recipe wpblog::default

describe file '/var/www/wordpress' do
  it { should be_directory }
end

describe file '/var/www/wordpress/wp-config.php' do
  it { should exist }
  its('content') do
    should match(/define\('DB_NAME', 'wpdb'\);/)
    should match /define\('DB_USER', 'wpuser'\);/
    should match(/define\('DB_HOST', '127.0.0.1'\);/)
    should match(/define\('DB_CHARSET', 'utf8'\);/)
    should match(/define\('DB_COLLATE', ''\);/)
    should match(/\$table_prefix\s+= 'wp_';/)
    should match(/define\('WP_DEBUG', false\);/)
  end
end

describe http('http://localhost:8080/wp-admin/install.php') do
  its('status') { should eq 200 }
  its('body') { should match(/Welcome to the famous five\-minute WordPress installation process/) }
end
