#% RB5009 VLAN Interfaces and Tagging %#
/interface vlan
add interface=bridge name=vlan10-LAN vlan-id=10
add interface=bridge name=vlan20-IoT vlan-id=20
add interface=bridge name=vlan30-NoT vlan-id=30

/interface bridge vlan
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=10
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=20
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=30
