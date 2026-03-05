#% CRS328 Bridge and Trunk configuration %#
/interface bridge
add name=bridge vlan-filtering=yes frame-types=admit-only-vlan-tagged pvid=1

# SFP+ trunk port to RB5009
/interface bridge port
add bridge=bridge interface=sfp-sfpplus1 frame-types=admit-only-vlan-tagged
