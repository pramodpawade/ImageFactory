title 'Connecity Stream - GSB Middleware Validation'

control 'Check nginx service' do
  impact 1.0
  title 'client: nginx service enabled and running'
  desc 'Make sure nginx service is enabled and running'
  describe service('nginx') do
  it { should be_running }
  it { should be_enabled }
	end
end

control 'Check /etc/nginx/ssl' do
  impact 1.0
  title 'client: Check /etc/nginx/ssl directory with necessary permissions exists'
  desc 'Check /etc/nginx/ssl directory with necessary permissions exists or not'
  describe directory ('/etc/nginx/ssl') do
    it { should exist }
    its('type') { should cmp 'directory' }
    its('mode') { should cmp '00755'}
  end
end

control 'Check /etc/nginx/' do
  impact 1.0
  title 'client: Check /etc/nginx/ directory with necessary permissions exists'
  desc 'Check /etc/nginx/ directory with necessary permissions exists'
  describe directory ('/etc/nginx/') do
    it { should exist }
    its('type') { should cmp 'directory' }
	its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    its('mode') { should cmp '00755'}
	
  end
end

control 'Check vault command' do
  impact 1.0
  title 'client: Check vault command is present'
  desc 'Check vault command exists or not'
  describe command('vault') do
	it { should exist }	
	end
end

control 'Check /usr/local/bin/vault' do
  impact 1.0
  title 'client: Check /usr/local/bin/vault binary file exists'
  desc 'Check /usr/local/bin/vault binary file exists'
  describe file ('/usr/local/bin/vault') do
    it { should exist }
    its('type') { should cmp 'file' }	
  end
end

control 'Check filebeat service' do
  impact 1.0
  title 'client: filebeat service enabled and running'
  desc 'Make sure filebeat service is enabled and running'
  describe service('filebeat') do
  it { should be_running }
  it { should be_enabled }
	end
end

