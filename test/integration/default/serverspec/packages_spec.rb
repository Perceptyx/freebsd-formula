require 'serverspec'
set :backend, :exec

describe 'freebsd/packages.sls' do
  describe "Bash" do
    it "is installed" do
      expect(package("bash")).to be_installed
    end
  end

  describe "NGiNX" do
    it "is installed" do
      expect(package("nginx")).to be_installed
    end
  end

  describe "Gettext Tools" do
    it "is installed from Saltstack repository" do
      expect(package("gettext-tools")).to be_installed
      expect(command("pkg query %R gettext-tools").stdout).to match('saltstack')
    end
  end

  describe "Docbook" do
    it "is installed from Saltstack repository" do
      expect(package("docbook")).to be_installed
      expect(command("pkg query %R docbook").stdout).to match('saltstack')
    end
  end

  describe "virtualbox-ose-additions-nox11" do
    it "is NOT installed" do
      expect(package("virtualbox-ose-additions-nox11")).to_not be_installed
    end
  end
end
