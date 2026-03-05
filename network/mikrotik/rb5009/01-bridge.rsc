#% RB5009 Bridge and Trunk configuration %#
/interface bridge
add name=bridge vlan-filtering=yes frame-types=admit-only-vlan-tagged pvid=1

# SFP+ trunk port to CRS328 (assumed port)
/interface bridge port
add bridge=bridge interface=sfp-sfpplus1 frame-types=admit-only-vlan-tagged
