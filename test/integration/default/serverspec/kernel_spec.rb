require 'serverspec'
set :backend, :exec

describe 'freebsd/kernel.sls' do
  describe kernel_module('pfsync') do
    it { should be_loaded }
  end

  describe kernel_module('carp') do
    it { should be_loaded }
  end
end
