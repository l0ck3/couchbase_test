Vagrant.configure("2") do |config|
  config.vm.box = "precise64"

  config.vm.provider "vmware_fusion" do |v|
    v.gui = false
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "1"
  end

  # COUCHBASE CLLUSTER
  num_couchbase_nodes = 3
  ip_addr_prefix = "192.168.50.10"

  1.upto(num_couchbase_nodes) do |num|

    node_name = ("couchbase-" + num.to_s).to_sym

    config.vm.define node_name do |node|
      node.vm.network :private_network, ip: ip_addr_prefix + num.to_s
    end

    # config.vm.provision :ansible do |ansible|
    #   ansible.playbook       = "config/ansible/couchbase.yml"
    #   ansible.inventory_file = "config/ansible/hosts"
    #   ansible.limit          = ip_addr_prefix + num.to_s
    #   ansible.sudo           = true
    # end

  end

  # APPLICATION NODE

  config.vm.define 'app-1' do |node|
    node.vm.network :private_network, ip: "192.168.70.101"
  end


end

