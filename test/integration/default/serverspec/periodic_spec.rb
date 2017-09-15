require 'serverspec'
set :backend, :exec

describe 'freebsd/periodic.sls' do
  describe file('/etc/periodic.conf.local') do
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'wheel' }
    it { should contain 'daily_output="/var/log/daily.log"' }
    it { should contain 'weekly_output="/var/log/weekly.log"' }
    it { should contain 'monthly_output="/var/log/monthly.log"' }
  end
end
