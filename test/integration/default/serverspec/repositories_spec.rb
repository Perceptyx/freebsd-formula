require 'serverspec'
set :backend, :exec

describe 'freebsd/repositories.sls' do
  describe file('/usr/local/etc/pkg/repos/area51.conf') do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain 'area51' }
    it { should contain 'url: "http://meatwad.mouf.net/rubick/poudriere/packages/110-amd64-kde/"' }
    it { should contain 'mirror_type: "http"' }
  end

  describe file('/usr/local/etc/pkg/repos/mycompany.conf') do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain 'mycompany' }
    it { should contain 'enabled: true' }
    it { should contain 'priority: 100' }
  end
end
