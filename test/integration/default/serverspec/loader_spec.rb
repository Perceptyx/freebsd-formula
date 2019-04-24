require 'serverspec'
set :backend, :exec

describe 'freebsd/loader.sls' do
  describe file('/boot/loader.conf') do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain '^vfs\.zfs\.arc_max\=.*$' }
  end
end
