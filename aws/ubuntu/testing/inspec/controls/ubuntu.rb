title 'Ubuntu OS Hardening Validation'

control '/etc/motd' do
  impact 1.0
  title 'client: Check motd file owner, group and permissions.'
  desc 'The motd should owned by root, only be writable by owner and readable to all.'
  describe file ('/etc/motd') do
    it { should exist }
    its('type') { should cmp 'file' }
    its('mode') { should cmp '00644'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
  end
end

control 'motd-02' do
  impact 1.0
  title 'client: Check for motd banner in /etc/motd .'
  desc 'Make sure motd banner is created in the machine'
  describe file ('/etc/motd') do
    its('content') { should match '\W*This is a monitored confidential My Ditch Bank System\W*'}
  end
end

control '/etc/issue.net' do
  impact 1.0
  title 'client: Check if Warning banner is updated in /etc/issue.net'
  desc 'The issue.net file should be created and owned by root, only be writable by owner and readable to all, Warning : Unauthorized access content should match'
  describe file ('/etc/issue.net') do
    it { should exist }
    its('type') { should cmp 'file' }
    its('mode') { should cmp '00644'}
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    its('content') { should match '\W*WARNING : Unauthorized access to this system is forbidden\W*'}
  end
end

control '/etc/ssh/sshd_config' do
  impact 1.0
  title 'client: Check if Banner /etc/issue.net is enabled in /etc/ssh/sshd_config file'
  desc 'Ensure Banner /etc/issue is present and uncommented in /etc/ssh/sshd_config'
  describe file ('/etc/ssh/sshd_config') do
  it {should exist}
  its ('content') {should match '^Banner /etc/issue.net$'}
  end
end

control 'unattended-upgrades' do
  impact 1.0
  title 'client: check if unattended-upgrades are installed in the machine'
  desc 'Ensure if unattended-upgrades are installed'
  describe package('unattended-upgrades') do
    it { should be_installed}
  end
end

control 'ssh service' do
  impact 1.0
  title 'client: sshd service enabled and running'
  desc 'Make sure sshd service is enabled and running'
  describe service('sshd') do
  it { should be_running }
  it { should be_enabled }
  end
end

control 'CIS-conf' do
  impact 1.0
  title 'client: CIS.conf file creation and check Disable unwanted file-systems'
  desc 'Check if CIS conf file is present in /etc/modprobe.d and it should be owner of ubuntu with readable and writeable by both owner and group. Check if unwanted filesystems are disabled '
  describe file ('/etc/modprobe.d/CIS.conf') do
    it {should exist}
    its ('mode') { should cmp '0664' }
    its ('owner') { should cmp 'ubuntu' }
    its ('content') { should match '^install cramfs /bin/false$' }
    its ('content') { should match '^install freevxfs /bin/false$' }
    its ('content') { should match '^install jffs2 /bin/false$' }
    its ('content') { should match '^install hfs /bin/false$' }
    its ('content') { should match '^install hfsplus /bin/false$' }
    its ('content') { should match '^install squashfs /bin/false$' }
    its ('content') { should match '^install udf /bin/false$' }
    its ('content') { should match '^install vfat /bin/true$' }
  end
end

control 'grub.cfg' do
  impact 1.0
  title 'client: check if grub.cfg is present in /boot/grub with owner, group and permissions'
  desc 'Make sure grub.cfg file is available and read and write only by the root with owner permission and no permission set to group/others'
  describe file ('/boot/grub/grub.cfg') do
    it {should exist}
    its ('mode') { should cmp '0600' }
    its ('owner') { should cmp 'root' }
    its ('group') { should cmp 'root'}
  end
end

control 'prelink' do
  impact 1.0
  title 'client: Check prelink package is removed'
  desc 'Make sure prelink package is removed from the machine'
  describe package('prelink') do
    it { should_not be_installed }
  end
end

control 'nis' do
  impact 1.0
  title 'client: Check nis package is removed'
  desc 'Make sure nis package is removed from the machine'
  describe package('nis') do
    it { should_not be_installed }
  end
end

control 'rsh-client' do
  impact 1.0
  title 'client: check if rsh-client package is removed'
  desc 'Make sure rsh-client package is removed from the machine'
  describe package('rsh-client') do
    it { should_not be_installed }
  end
end

control 'rsh-redone-client' do
  impact 1.0
  title 'client: check if rsh-redone-client package is removed'
  desc 'Make sure rsh-redone-client package is removed from the machine'
  describe package('rsh-redone-client') do
    it { should_not be_installed }
  end
end

control 'talk' do
  impact 1.0
  title 'client: check if talk package is removed'
  desc 'Make sure talk package is removed from the machine'
  describe package('talk') do
    it { should_not be_installed }
  end
end

control 'telnet' do
  impact 1.0
  title 'client: check if telnet package is removed'
  desc 'Make sure telnet package is removed from the machine'
  describe package('telnet') do
    it { should_not be_installed }
  end
end

control 'ldap-utils' do
  impact 1.0
  title 'client: check if ldap-utils package is removed'
  desc 'Make sure ldap-utils package is removed from the machine'
  describe package('ldap-utils') do
    it { should_not be_installed }
  end
end

control 'auditd installed' do
  impact 1.0
  title 'client: check if auditd package is installed'
  desc 'Make sure auditd package is installed in the machine'
  describe package('auditd') do
    it { should be_installed }
  end
end

control 'auditd service' do
  impact 1.0
  title 'client: check if auditd service is running '
  desc 'Make sure auditd service is running from the machine'
  describe service('auditd') do
    it { should be_running }
  end
end

control 'auditdconf' do
  impact 1.0
  title 'client: check if auditd-conf exist'
  desc 'Make sure auditd-conf exist'
  describe file('/etc/audit/auditd.conf') do
  it { should exist }
  end
end

control 'auditd-conf-backup' do
  impact 1.0
  title 'client: check if backup of auditd-conf exist'
  desc 'Make sure auditd-conf backup exist in /root/script'
  describe file ('/root/script/auditd.conf') do
    it { should exist }
  end
end

control 'auditf-conf-01' do
  impact 1.0
  title 'client: Speciify max_log_file_action = KEEP_LOGS'
  desc 'Make sure max_log_file_action = KEEP_LOGS is changed in /etc/audit/auditd.conf'
  describe file ('/etc/audit/auditd.conf') do
    its ('content') { should match '^max_log_file_action = KEEP_LOGS$'}
  end
end

control 'grub.d' do
  impact 1.0
  title 'client: Check grub.d exist'
  desc 'Verify if grub.d exist in /etc/default'
  describe file ('/etc/default/grub.d') do
    it {should exist}
  end
end

control 'audit.rules-01' do
  impact 1.0
  title 'client: Adjust time settings for 32 arch'
  desc 'Make sure -a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change is present in /etc/audit/audit.rules'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change$'}
  end
end

control 'audit.rules-02' do
  impact 1.0
  title 'client: Adjust time settings for 64 arch'
  desc 'Make sure -a always,exit -F arch=b64 -S clock_settime -k time-change is present in /etc/audit/audit.rules'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b64 -S clock_settime -k time-change$'}
  end
end

control 'audit.rules-03' do
  impact 1.0
  title 'client: set time settings for 32 arch'
  desc 'Make sure -a always,exit -F arch=b32 -S clock_settime -k time-change is present in /etc/audit/audit.rules'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b32 -S clock_settime -k time-change$'}
  end
end

control 'audit.rules-04' do
  impact 1.0
  title 'client: Check local time '
  desc 'Make sure -w /etc/localtime -p wa -k time-change is present in /etc/audit/audit.rules'
  describe file ('/etc/audit/audit.rules') do
  its ('content' ) { should match '^-w /etc/localtime -p wa -k time-change$'}
  end
end

control 'audit.rules-05' do
  impact 1.0
  title 'client:modify group information are collected via auditd'
  desc 'Check group information are collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/group -p wa -k identity$'}
  end
end

control 'audit.rules-06' do
  impact 1.0
  title 'client:modify password information are collected via auditd'
  desc 'Check password information are collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/passwd -p wa -k identity$'}
  end
end

control 'audit.rules-07' do
  impact 1.0
  title 'client:modify gshadow information are collected via auditd'
  desc 'Check gshadow information are collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/gshadow -p wa -k identity$'}
  end
end

control 'audit.rules-08' do
  impact 1.0
  title 'client:modify shadow information are collected via auditd'
  desc 'Check shadow information are collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/shadow -p wa -k identity$'}
  end
end

control 'audit.rules-09' do
  impact 1.0
  title 'client:modify opassword information are collected via auditd'
  desc 'Check opassword information are collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/security/opasswd -p wa -k identity$'}
  end
end

control 'audit.rules-10' do
  impact 1.0
  title 'client: modify the systems network environment are collected'
  desc 'Modify system network in 32bit arch'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale$'}
  end
end

control 'audit.rules-11' do
  impact 1.0
  title 'client: modify the systems network environment are collected'
  desc 'Modify system network in 64bit arch'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale$'}
  end
end

control  'audit.rules-12' do
  impact 1.0
  title 'client: modify the system network environment'
  desc 'Modify system network'
  describe file ('/etc/audit/audit.rules') do
  its ('content' ) { should match '^-w /etc/issue -p wa -k system-locale$'}
  end
end

control 'audit.rules-13' do
  impact 1.0
  title 'client: modify the system network environment in /etc/issue.net'
  desc 'Modify system network'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/issue.net -p wa -k system-locale$'}
  end
end

control 'audit.rules-14' do
  impact 1.0
  title 'client: modify the system network environment in /etc/hosts'
  desc 'Modify systems network environment'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/hosts -p wa -k system-locale$'}
  end
end

control 'audit.rules-15' do
  impact 1.0
  title 'client: modify the system network environment in /etc/hosts'
  desc 'Modify systems network environment'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/network -p wa -k system-locale$'}
  end
end

control 'audit.rules-16' do
  impact 1.0
  title 'client: modify the system network environment in /etc/hosts'
  desc 'Modify systems network environment'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/networks -p wa -k system-locale'}
  end
end

control 'audit.rules-17' do
  impact 1.0
  title 'Ensure session initiation information is collected via auditd'
  desc 'session initiation information is collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /var/run/utmp -p wa -k session$'}
  end
end

control 'audit.rules-18' do
  impact 1.0
  title 'Ensure session initiation information is collected via auditd'
  desc 'session initiation information is collected'
  describe file ('/etc/audit/audit.rules') do
  its ('content' ) { should match '^-w /var/log/wtmp -p wa -k session$'}
  end
end

control 'audit.rules-19' do
  impact 1.0
  title 'Ensure session initiation information is collected via auditd'
  desc 'session initiation information is collected'
  describe file ('/etc/audit/audit.rules') do
  its ('content' ) { should match '^-w /var/log/btmp -p wa -k session$'}
  end
end

control 'audit.rules-20' do
  impact 1.0
  title 'Ensure login and logout events are collected via auditd'
  desc 'Ensure login and logout events are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /var/log/faillog -p wa -k logins$'}
  end
end

control 'audit.rules-21' do
  impact 1.0
  title 'Ensure login and logout events are collected via auditd'
  desc 'Ensure login and logout events are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /var/log/lastlog -p wa -k logins$'}
  end
end

control 'audit.rules-22' do
  impact 1.0
  title 'Ensure login and logout events are collected via auditd'
  desc 'Ensure login and logout events are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /var/log/tallylog -p wa -k logins$'}
  end
end

control 'audit.rules-23' do
  impact 1.0
  title 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  desc 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access$'}
  end
end

control 'audit.rules-24' do
  impact 1.0
  title 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  desc 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access$'}
  end
end

control 'audit.rules-25' do
  impact 1.0
  title 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  desc 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access$'}
  end
end

control 'audit.rules-26' do
  impact 1.0
  title 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  desc 'Ensure unsuccessful unauthorized file access attempts are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access$'}
  end
end

control 'audit.rules-27' do
  impact 1.0
  title 'Ensure successful file system mounts are collected via auditd'
  desc 'Ensure successful file system mounts are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts$'}
  end
end

control 'audit.rules-29' do
  impact 1.0
  title 'Ensure file deletion events by users are collected via auditd'
  desc 'Ensure file deletion events by users are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete$'}
  end
end

control 'audit.rules-30' do
  impact 1.0
  title 'Ensure file deletion events by users are collected via auditd'
  desc 'Ensure file deletion events by users are collected via auditd'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete$'}
  end
end

control 'audit.rules-31' do
  impact 1.0
  title 'Ensure changes to system administration scope (sudoers) is collected via auditd'
  desc 'changes to system administration scope (sudoers)'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/sudoers -p wa -k scope$'}
  end
end

control 'audit.rules-32' do
  impact 1.0
  title 'Ensure changes to system administration scope (sudoers) is collected via auditd'
  desc 'changes to system administration scope (sudoers)'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /etc/sudoers.d -p wa -k scope$'}
  end
end

control 'audit.rules-33' do
  impact 1.0
  title 'Ensure system administrator actions (sudolog) are collected via auditd(provided su should be disabled'
  desc 'system administrator actions (sudolog) are collected '
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /var/log/sudo.log -p wa -k actions$'}
  end
end

control 'audit.rules-33' do
  impact 1.0
  title 'Ensure kernel module loading and unloading is collected via auditd'
  desc 'kernel module loading and unloading is collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /sbin/insmod -p x -k modules$'}
  end
end

control 'audit.rules-34' do
  impact 1.0
  title 'Ensure kernel module loading and unloading is collected via auditd'
  desc 'kernel module loading and unloading is collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-w /sbin/modprobe -p x -k modules$'}
  end
end

control 'audit.rules-35' do
  impact 1.0
  title 'client: Ensure kernel module loading and unloading is collected via auditd'
  desc 'kernel module loading and unloading is collected'
  describe file ('/etc/audit/audit.rules') do
    its ('content' ) { should match '^-a always,exit arch=b64 -S init_module -S delete_module -k modules$'}
  end
end

control 'audit.rules-36' do
  impact 1.0
  title 'client: Auditd service should be running '
  desc ' Ensure Auditd service is running '
  describe service ('auditd') do
    it { should be_running }
  end
end

control 'rsyslog' do
  impact 1.0
  title 'client: rsyslog service should be running '
  desc ' Ensure rsyslog service is running '
  describe systemd_service('rsyslog') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'cron.allow' do
  impact 1.0
  title 'client: cron.allow should be enabled and read and write only by root. Others/group permission should be removed'
  desc 'Make sure cron.allow should be enabled and read and write only by root'
  describe file ('/etc/cron.allow') do
    it {should exist}
    its ('mode') {should cmp '0600'}
  end
end

control 'cron.allow-01' do
  impact 1.0
  title 'client: cron.allow entry as root'
  desc 'Make sure cron.allow file has root entry'
  describe file ('/etc/cron.allow') do
    its ('content') {should match '^root$'}
  end
end

control 'cron' do
  impact 1.0
  title 'client: Cron service enabled and running'
  desc 'Make sure Cron service enabled and running'
  describe service ('cron') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'sshd_config' do
  impact 1.0
  title 'client: sshd_config should exist with only root as owner and group with read and write permission'
  desc 'sshd_config should exist with only root as owner and group with read and write permission'
  describe file ('/etc/ssh/sshd_config') do
    it {should exist}
    its ('mode') {should cmp '0600'}
    its ('owner') { should cmp 'root'}
    its ('group') { should cmp 'root'}
  end
end

control 'sshd_config-01' do
  impact 1.0
  title 'client: sshd_config contain Protocol 2'
  desc 'sshd_config in /etc/ssh/sshd_config should have Protocol  2'
  describe file ('/etc/ssh/sshd_config') do
    its ('content') { should match '^Protocol  2$'}
  end
end

control 'sshd_config-02' do
  impact 1.0
  title 'client: sshd_config contain LogLevel INFO'
  desc 'sshd_config in /etc/ssh/sshd_config should have LogLevel INFO'
  describe file ('/etc/ssh/sshd_config') do
    its ('content') { should match '^LogLevel INFO$'}
  end
end

control 'sshd_config-03' do
  impact 1.0
  title 'client: sshd_config contain X11Forwarding no'
  desc 'sshd_config in /etc/ssh/sshd_config should have X11Forwarding no'
  describe file ('/etc/ssh/sshd_config') do
  its ('content') { should match '^X11Forwarding no$'}
  end
end

control 'sshd_config-04' do
  impact 1.0
  title 'client: sshd_config contain MaxAuthTries 4'
  desc 'sshd_config in /etc/ssh/sshd_config should have MaxAuthTries 4'
  describe file ('/etc/ssh/sshd_config') do
    its ('content') { should match '^MaxAuthTries 4$'}
  end
end

control 'sshd_config-05' do
  impact 1.0
  title 'client: sshd_config contain ClientAliveInterval 300'
  desc 'sshd_config in /etc/ssh/sshd_config should have ClientAliveInterval 300'
  describe file ('/etc/ssh/sshd_config') do
    its ('content') { should match '^ClientAliveInterval 300$'}
  end
end

control 'sshd_config-06' do
  impact 1.0
  title 'client: sshd_config contain ClientAliveCountMax 10'
  desc 'sshd_config in /etc/ssh/sshd_config should have ClientAliveCountMax 10'
  describe file ('/etc/ssh/sshd_config') do
    its ('content') { should match '^ClientAliveCountMax 10$'}
  end
end

control 'sshd_config-07' do
  impact 1.0
  title 'client: sshd_config contain PermitEmptyPasswords no'
  desc 'sshd_config in /etc/ssh/sshd_config should have PermitEmptyPasswords no'
  describe file ('/etc/ssh/sshd_config') do
    its ('content') { should match '^PermitEmptyPasswords no$'}
  end
end

control 'sshd_config-08' do
  impact 1.0
  title 'client: sshd_config contain LoginGraceTime 60'
  desc 'sshd_config in /etc/ssh/sshd_config should have LoginGraceTime 60'
  describe file ('/etc/ssh/sshd_config') do
    its ('content') { should match '^LoginGraceTime 60$'}
  end
end

control 'sshd_service' do
  impact 1.0
  title 'client: sshd service should be running'
  desc ' Check if sshd service is running. It should be running'
   describe service ('sshd') do
    it {should be_running}
  end
end

control 'login.defs' do
  impact 1.0
  title 'client: check if login.defs is present'
  desc 'Make sure backup is present in /root/scripts'
  describe file ('/root/script/login.defs') do
    it { should exist }
  end
end

control '/etc/passwd' do
  impact 1.0
  title 'client: permissions on /etc/passwd are configured '
  desc 'Ensure /etc/passwd has read and write access only to the root and owner as root with group as root'
  describe file ('/etc/passwd') do
    it { should exist}
    its ('mode') { should cmp '0644' }
    its ('owner') { should cmp 'root' }
    its ('group') { should cmp 'root'}
  end
end

control '/etc/shadow' do
  impact 1.0
  title 'client: permissions on /etc/shadow are configured '
  desc 'Ensure /etc/shadow has owner as root and group as shadow with read and write only to the root'
  describe file ('/etc/shadow') do
    it { should exist}
    its ('mode') { should cmp '0640' }
    its ('owner') { should cmp 'root' }
    its ('group') { should cmp 'shadow'}
  end
end

control '/etc/group' do
  impact 1.0
  title 'client: permissions on /etc/group are configured '
  desc 'Ensure /etc/group has root as owner and group with read and write permission only to the user'
  describe file ('/etc/group') do
    it { should exist}
    its ('mode') { should cmp '0644' }
    its ('owner') { should cmp 'root' }
    its ('group') { should cmp 'root'}
  end
end

control '/etc/gshadow' do
  impact 1.0
  title 'client: permissions on /etc/gshadow are configured '
  desc 'Ensure /etc/gshadow should exist has root owner and group as shadow with read and write permission only to the user'
  describe file ('/etc/gshadow') do
    it { should exist}
    its ('mode') { should cmp '0600' }
    its ('owner') { should cmp 'root' }
    its ('group') { should cmp 'shadow'}
  end
end

control '/etc/passwd-' do
  impact 1.0
  title 'client: permissions on /etc/passwd-  are configured '
  desc 'Ensure /etc/passwd- should exist has root as owner and group with read and write permission only to root'
  describe file ('/etc/passwd-') do
    it { should exist}
    its ('mode') { should cmp '0600' }
    its ('owner') { should cmp 'root' }
    its ('group') { should cmp 'root'}
  end
end
