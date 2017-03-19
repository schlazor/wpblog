# # encoding: utf-8

# Inspec test for recipe wpblog::web

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe port(80) do
  it { should be_listening }
  its('processes') { should include 'nginx:' }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '0.0.0.0' }
end

describe service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
