# # encoding: utf-8

# Inspec test for recipe wpblog::php

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe service('php-fpm') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
