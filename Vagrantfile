VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "browncow"
  config.vm.box = "articulate-ubuntu"
  config.vm.network :private_network, ip: "192.168.50.4"
  
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [ "recipe[browncow]" ]
  end
end
