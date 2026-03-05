#% RB5009 Firewall and Isolation Rules %#
/ip firewall address-list
add address=192.168.1.0/24 list=Trusted
add address=192.168.20.0/24 list=IoT
add address=192.168.30.0/24 list=NoT

/ip firewall filter
# Allow established/related
add action=accept chain=forward connection-state=established,related
# IoT (VLAN 20) can access WAN but not LAN
add action=drop chain=forward in-interface=vlan20-IoT out-interface=vlan10-LAN dst-address-list=Trusted
# NoT (VLAN 30) - No WAN access
# Assuming ether1 is WAN
add action=drop chain=forward in-interface=vlan30-NoT out-interface=ether1
