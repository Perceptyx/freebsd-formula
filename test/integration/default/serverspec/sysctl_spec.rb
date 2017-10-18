require 'serverspec'
set :backend, :exec

describe 'freebsd/sysctl.sls' do
  # Even when this is running under FreeBSD `linux_kernel_parameter` works in FreeBSD
  context linux_kernel_parameter('net.inet.ip.portrange.first') do
    its(:value) { should eq 20000 }
  end

  context linux_kernel_parameter('kern.coredump') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('kern.ipc.somaxconn') do
    its(:value) { should eq 1024 }
  end
end
