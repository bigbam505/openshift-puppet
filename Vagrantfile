# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "fedora"

  if ENV['VAGRANT_DEFAULT_PROVIDER'] == 'vmware_fusion'
    config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vf503.box"
  else
    config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vbox4210.box"
  end

  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # config.vm.network :private_network, ip: "192.168.33.10"

  # config.vm.network :public_network

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "default.pp"
    puppet.module_path   = "modules"
  end
end
