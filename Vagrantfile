# -*- mode: ruby -*-
# vi: set ft=ruby :

# external net : 10.0.2.0/24
#          management  ,  underlay    
PREFIXES=["10.118.118" , "172.16.118"]

machines = {
#   Name         CPU, RAM, NETs
'controller' => [  2,   3, {1 => "10"              }],
'network'    => [  1,   1, {1 => "20" , 2 => "20"  }],
'compute01'  => [  2,   2, {1 => "101", 2 => "101" }],
'compute02'  => [  2,   2, {1 => "102", 2 => "102" }],
'compute03'  => [  2,   2, {1 => "103", 2 => "103" }],
}

Vagrant.configure("2") do |config|

	config.vm.box = "packstack-node"
    macnum = 2
	machines.each do |name, (cpu, ram, nets)|

		hostname = "%s" % [name]

		config.vm.define "#{hostname}" do |box|
            box.vm.base_mac = "080227aa620#{macnum}"
            macnum = macnum + 1

			box.vm.hostname = "#{hostname}.local"

			nets.each {|key, suffix|
				box.vm.network :private_network,
						ip: PREFIXES[key-1] + "." + suffix
			}

			box.vm.provider :virtualbox do |vbox|
				vbox.customize ["modifyvm", :id, "--cpus",   cpu]
				vbox.customize ["modifyvm", :id, "--memory", ram * 1024]
			end

            #box.vm.provision :shell, :inline => $script
            if hostname == "network"
                box.vm.provision :shell, :path => "extnet_init.sh"
            else
                box.vm.provision :shell, :path => "provision.sh"
            end

		end
	end
end
