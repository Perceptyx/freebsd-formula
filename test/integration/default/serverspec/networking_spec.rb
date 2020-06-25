require 'serverspec'
require 'yaml'

set :backend, :exec

$vm_type = YAML.load(`salt-call --local --config-dir=/srv -l quiet --out yaml grains.get virtual`)['local']

describe 'freebsd/networking.sls' do

  if $vm_type == "kvm"
    # We skip couple of tests when running in Travis CI

    it "/etc/resolv.conf should have 'nameserver 192.168.121.1'" do
      expect(file("/etc/resolv.conf").content).to match(/^nameserver 192.168.121.1$/)
    end

  else

    it "em0 is configured with dhcp" do
      expect(command("/usr/sbin/sysrc -n ifconfig_em0").stdout).to match('^dhcp$')
    end

    it "/etc/resolv.conf should have 'nameserver 8.8.8.8'" do
      expect(file("/etc/resolv.conf").content).to match(/^nameserver 8.8.8.8$/)
    end

    it "/etc/resolv.conf should have 'nameserver 8.8.4.4'" do
      expect(file("/etc/resolv.conf").content).to match(/^nameserver 8.8.4.4$/)
    end

  end

  it "Gateway mode is enabled" do
    expect(command("/usr/sbin/sysrc -n gateway_enable").stdout).to match('^YES$')
  end

  it "/etc/resolv.conf should have 'search perceptyx.com domain.com'" do
    expect(file("/etc/resolv.conf").content).to match(/^search perceptyx.com domain.com$/)
  end

  it "em1 is configured with up" do
    expect(command("/usr/sbin/sysrc -n ifconfig_em1").stdout).to match('^up$')
  end

  it "em2 is configured with up" do
    expect(command("/usr/sbin/sysrc -n ifconfig_em2").stdout).to match('^up$')
  end

  it "em2 is configured with up" do
    expect(command("/usr/sbin/sysrc -n ifconfig_em2").stdout).to match('^up$')
  end

  describe interface('em3') do
    it { should have_ipv4_address("192.168.254.253/24") }
  end

  describe interface('lagg0') do
    it { should exist }
    it { should have_ipv4_address("10.200.252.2/22") }
    it { should have_ipv4_address("10.200.252.1/22") }
  end

end
