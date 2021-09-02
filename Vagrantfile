# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "centos" do |centos|
    centos.vm.box = "tomato_clean"
    centos.vm.box_url = "file://~/builds/Vagrant/tomato_clean/tomato_meta.json"
    centos.ssh.private_key_path = "~/.ssh/keys/vagrant-tomato.key"

    centos.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
    centos.vm.network :forwarded_port, guest: 22, host: 4444, auto_correct: true
    centos.vm.synced_folder '.', '/vagrant', disabled: true
    centos.vm.synced_folder '.', '/opt/sparrow/plugins/private', type: "sshfs"
  end
  config.vm.define "archlinux" do |arch|
    arch.vm.box = "spigell/archlinux"

    arch.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
    arch.vm.network :forwarded_port, guest: 22, host: 4445, auto_correct: true
    arch.vm.synced_folder '.', '/vagrant', disabled: true
    arch.vm.synced_folder '.', '/opt/sparrow/plugins/private', type: "sshfs"
  end
end
