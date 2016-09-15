Vagrant.configure(2) do |config|
  config.vm.box = "bento/fedora-24"
  config.vm.hostname = "ansible.lab.local"
  config.vm.provision "shell", path: "provision-fedora-24.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 2048
    vb.name = "ansible.lab.local"
    vb.customize ["modifyvm", :id, "--natnet1", "192.168.255.0/24"]
  end
end
