require 'serverspec'
set :backend, :exec

describe 'freebsd/networking.sls' do
  it "em0 is configured with syncdhcp" do
    expect(command("/usr/sbin/sysrc -n ifconfig_em0").stdout).to match('^syncdhcp$')
  end

  it "Gateway mode is enabled" do
    expect(command("/usr/sbin/sysrc -n gateway_enable").stdout).to match('^YES$')
  end

  it "/etc/resolv.conf should have 'nameserver 8.8.8.8'" do
    expect(file("/etc/resolv.conf").content).to match(/^nameserver 8.8.8.8$/)
  end

  it "/etc/resolv.conf should have 'nameserver 8.8.4.4'" do
    expect(file("/etc/resolv.conf").content).to match(/^nameserver 8.8.4.4$/)
  end

  it "/etc/resolv.conf should have 'search perceptyx.com domain.com'" do
    expect(file("/etc/resolv.conf").content).to match(/^search perceptyx.com domain.com$/)
  end
end
