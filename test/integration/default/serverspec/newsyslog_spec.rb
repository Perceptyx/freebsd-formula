require 'serverspec'
set :backend, :exec

describe 'freebsd/newsyslog.sls' do
  describe file('/etc/newsyslog.conf.d/my_app') do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain '/var/log/my_app.log' }
    it { should contain '@T00' }
    it { should contain 'JBN' }
  end

  describe file('/etc/newsyslog.conf.d/nginx') do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain '/var/log/nginx/*.log' }
    it { should contain '/var/run/nginx.pid' }
    it { should contain '30' }
  end
end
