#% RB5009 DHCP Server configuration %#
/ip pool
add name=pool-LAN ranges=192.168.1.100-192.168.1.254
add name=pool-IoT ranges=192.168.20.100-192.168.20.254
add name=pool-NoT ranges=192.168.30.100-192.168.30.254

/ip dhcp-server
add address-pool=pool-LAN interface=vlan10-LAN name=dhcp-LAN
add address-pool=pool-IoT interface=vlan20-IoT name=dhcp-IoT
add address-pool=pool-NoT interface=vlan30-NoT name=dhcp-NoT

/ip dhcp-server network
add address=192.168.1.0/24 dns-server=192.168.1.16 gateway=192.168.1.1
add address=192.168.20.0/24 dns-server=192.168.1.16 gateway=192.168.20.1
add address=192.168.30.0/24 dns-server=192.168.1.1 gateway=192.168.30.1
