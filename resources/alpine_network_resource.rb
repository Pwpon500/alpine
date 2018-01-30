resource_name :alpine_network_resource
provides :network_interface, platform: 'alpine'

property :device, String, name_property: true

property :onboot, [true, false], default: true
property :bootproto, String, default: 'dhcp'
property :address, String
property :netmask, String
property :gateway, String
property :broadcast, String
property :mtu, String
property :pre_up, String
property :up, String
property :post_up, String
property :pre_down, String
property :down, String
property :post_down, String

default_action :create

action :create do
    directory '/etc/network/interfaces.d'

    template "/etc/network/interfaces.d/#{device}" do
        source 'alpine_interface.erb'
        variables(
            auto: onboot,
            type: bootproto,
            address: address,
            netmask: netmask,
            gateway: gateway,
            broadcast: broadcast,
            mtu: mtu,
            pre_up: pre_up,
            up: up,
            post_up: post_up,
            pre_down: pre_down,
            down: down,
            post_down: post_down
        )
    end

    template '/etc/network/interfaces' do
        source 'interfaces.erb'
        variables(
            interfaces: node['interfaces']
        )
    end

    shell_out!("ifup #{device}")
end

action :nothing do
end
