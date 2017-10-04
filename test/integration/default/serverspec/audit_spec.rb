require 'serverspec'
set :backend, :exec

describe 'freebsd/audit.sls' do
  it "auditd service is running" do
    expect(service("auditd")).to be_running
  end

  it "auditd service is enabled" do
    expect(service("auditd")).to be_enabled
  end

  describe file('/etc/security/audit_control') do
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain 'dir:/var/audit' }
    it { should contain 'dist:off' }
    it { should contain 'flags:lo,aa' }
    it { should contain 'minfree:5' }
    it { should contain 'naflags:lo,aa' }
    it { should contain 'policy:cnt,argv' }
    it { should contain 'filesz:2M' }
    it { should contain 'expire-after:10M' }
  end

  describe file('/etc/security/audit_user') do
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain 'root:lo:no' }
  end
end
