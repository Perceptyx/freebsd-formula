require 'serverspec'
set :backend, :exec

describe 'freebsd/repositories.sls' do
  describe file('/usr/local/etc/pkg/repos/saltstack.conf') do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain 'saltstack' }
    it { should contain 'url: "http://repo.saltstack.com/freebsd/${ABI}/"' }
    it { should contain 'mirror_type: "http"' }
    it { should contain 'enabled: false' }
  end
end
