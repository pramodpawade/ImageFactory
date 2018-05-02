title 'Connecity Stream - MQTT Middleware Validation'

control 'Check java package' do
  impact 1.0
  title 'client: Check java package installed or not'
  desc 'Check java package installed or not'
  describe command('java') do
	it { should exist }	
	end
end


control 'Check /home/ubuntu/hivemq-3.3.1/' do
  impact 1.0
  title 'client: Check /home/ubuntu/hivemq-3.3.1/ directory with necessary permissions exists'
  desc 'Check /home/ubuntu/hivemq-3.3.1/ directory with necessary permissions exists or not'
  describe directory ('/home/ubuntu/hivemq-3.3.1/') do
    it { should exist }
    its('type') { should cmp 'directory' }
    its('mode') { should cmp '00755'}
  end
end
