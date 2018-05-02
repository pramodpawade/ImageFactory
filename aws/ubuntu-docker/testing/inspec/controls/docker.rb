title 'Docker Hardening Validation using Inspec Testing Framework'

#Check if docker exists
only_if do
  command('docker').exist?
end

control 'Check /etc/fstab file exists' do
  impact 1.0
  title 'client: Check /etc/fstab exists or not'
  desc '/etc/fstab file should exist'
describe file('/etc/fstab') do
 it { should exist }
  end
end

control 'Check /etc/fstab file permissions' do
  impact 1.0
  title 'client: Check /etc/fstab file owner, group and permissions'
  desc '/etc/fstab file should owned by root, only be writable by owner and readable to all'
  describe file ('/etc/fstab') do
    it { should exist }
    its('type') { should cmp 'file' }
    its('mode') { should cmp '0644'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
  end
end

control 'Check /etc/fstab file content' do
  impact 1.0
  title 'client: Check /etc/fstab file contains separate partition for docker'
  desc '/etc/fstab file should contain separate partition for docker container in path /var/lib/docker'
  describe file ('/etc/fstab') do
    its('content') { should match '^/dev/xvdb /var/lib/docker ext4 defaults 0 0$'}
  end
end

control 'Check Docker trusted group users' do
  impact 1.0
  title 'client: Check trusted users exist for docker daemon'
  desc 'Docker daemon should have atleast one trusted group user like root user by default'
  describe command('getent group docker') do
  its('stdout') { should_not eq '' }
  end
end

control 'audit.rules-1' do
  impact 1.0
  title 'client: Audit docker daemon'
  desc 'Audit docker daemon'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /usr/bin/docker -k docker$'}
  end
end

control 'audit.rules-2' do
  impact 1.0
  title 'client: Audit Docker files and directories - /var/lib/docker'
  desc 'Audit Docker files and directories - /var/lib/docker'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /var/lib/docker -k docker$'}
  end
end

control 'audit.rules-3' do
  impact 1.0
  title 'client: Audit Docker files and directories - /etc/docker'
  desc 'Audit Docker files and directories - /etc/docker'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/docker -k docker$'}
  end
end

control 'audit.rules-4' do
  impact 1.0
  title 'client: Audit Docker files and directories - docker.service'
  desc 'Audit Docker files and directories - docker.service'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /usr/lib/systemd/system/docker.service -k docker$'}
  end
end

control 'audit.rules-5' do
  impact 1.0
  title 'client: Audit Docker files and directories - docker.socket'
  desc 'Audit Docker files and directories - docker.socket'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /usr/lib/systemd/system/docker.socket -k docker$'}
  end
end

control 'audit.rules-6' do
  impact 1.0
  title 'client: Audit Docker files and directories - /etc/default/docker'
  desc 'Audit Docker files and directories - /etc/default/docker'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/default/docker -k docker$'}
  end
end

control 'audit.rules-7' do
  impact 1.0
  title 'client: Audit Docker files and directories - /etc/docker/daemon.json'
  desc 'Audit Docker files and directories - /etc/docker/daemon.json'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/docker/daemon.json -k docker$'}
  end
end

control 'audit.rules-8' do
  impact 1.0
  title 'client: Audit Docker files and directories - /usr/bin/docker-containerd'
  desc 'Audit Docker files and directories - /usr/bin/docker-containerd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /usr/bin/docker-containerd -k docker$'}
  end
end

control 'audit.rules-9' do
  impact 1.0
  title 'client: Audit Docker files and directories - /usr/bin/docker-runc'
  desc 'Audit Docker files and directories - /usr/bin/docker-runc'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /usr/bin/docker-runc -k docker$'}
  end
end

control 'audit.rules-10' do
  impact 1.0
  title 'client: Auditd service should be running '
  desc ' Ensure Auditd service is running '
  describe service ('auditd') do
    it { should be_running }
  end
end

control 'Check /lib/systemd/system/docker.service' do
  impact 1.0
  title 'client: Verify that docker.service file ownership is set to root:root and Permission is 644'
  desc 'Verify that docker.service file ownership is set to root:root and Permission is 644'
  describe file ('/lib/systemd/system/docker.service') do
    it { should exist }
    its('type') { should cmp 'file' }
    its('mode') { should cmp '0644'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
  end
end

control 'Check /lib/systemd/system/docker.socket' do
  impact 1.0
  title 'client: Verify that docker.socket file ownership is set to root:root and permission is 644'
  desc 'Verify that docker.socket file ownership is set to root:root and permission is 644'
  describe file ('/lib/systemd/system/docker.socket') do
    it { should exist }
    its('type') { should cmp 'file' }
    its('mode') { should cmp '0644'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
  end
end

control 'Check /etc/docker' do
  impact 1.0
  title 'client: Verify that /etc/docker directory ownership is set to root:root and permission is 755'
  desc 'Verify that /etc/docker directory ownership is set to root:root and permission is 755'
  describe directory ('/etc/docker') do
    it { should exist }
    its('type') { should cmp 'directory' }
    its('mode') { should cmp '0755'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
  end
end

control 'Check /var/run/docker.sock' do
  impact 1.0
  title 'client: Verify that Docker socket file ownership is set to root:docker and permission is 660'
  desc 'Verify that Docker socket file ownership is set to root:docker and permission is 660'
  describe file ('/var/run/docker.sock') do
    it { should exist }
    its('type') { should cmp 'socket' }
    its('mode') { should cmp '0660'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'docker' }
  end
end

control 'Check /etc/default/docker' do
  impact 1.0
  title 'client: Verify that /etc/default/docker file ownership is set to root:root and permission is 644'
  desc 'Verify that /etc/default/docker file ownership is set to root:root and permission is 644'
  describe file ('/etc/default/docker') do
    it { should exist }
    its('type') { should cmp 'file' }
    its('mode') { should cmp '0644'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
  end
end


control 'Check Docker logging level' do
  impact 1.0
  title 'client: Set Docker the logging level'
  desc 'Set Docker the logging level'
  describe command('ps -ef | grep dockerd | grep log-level=info') do
  its('stdout') { should_not eq '' }
  end
end

control 'Check Docker Containers Network Traffic' do
  impact 1.0
  title 'client: Restrict network traffic between Docker containers'
  desc 'Restrict network traffic between Docker containers'
  describe command('ps -ef | grep dockerd | grep icc=false') do
  its('stdout') { should_not eq '' }
  end
end

control 'Check Docker access to Iptables' do
  impact 1.0
  title 'client: Allow Docker to make changes to iptables'
  desc 'Allow Docker to make changes to iptables'
  describe command('ps -ef | grep dockerd | grep iptables=true') do
  its('stdout') { should_not eq '' }
  end
end

control 'Check Docker legacy registry' do
  impact 1.0
  title 'client: Disable operations on legacy registry (v1)'
  desc 'Disable operations on legacy registry (v1)'
  describe command('ps -ef | grep dockerd | grep disable-legacy-registry') do
  its('stdout') { should_not eq '' }
  end
end

control 'Check Docker Userland Proxy' do
  impact 1.0
  title 'client: Disable Userland Proxy'
  desc 'Disable Userland Proxy'
  describe command('ps -ef | grep dockerd | grep userland-proxy=false') do
  its('stdout') { should_not eq '' }
  end
end

control 'Check Docker Live Restore' do
  impact 1.0
  title 'client: Enable live restore for Docker'
  desc 'Enable live restore for Docker'
  describe command('ps -ef | grep dockerd | grep live-restore') do
  its('stdout') { should_not eq '' }
  end
end