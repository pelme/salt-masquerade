# salt-masquerade

These salt states will turn your Debian machine into a basic NAT/masquerade gateway.

## Requirements

 * Two network interfaces: one connected to the internet, one connected to your LAN
 * An Debian 7.0 (wheezy) installation (it might work on other versions/distributions, )

## Features

Applying these states will enable:

 * Network interface configuration for your LAN
 * DNS and DHCP provided by dnsmasq
 * Local DNS aliases for your known machines (see ethers below)
 * Enable IP forwarding
 * Manage iptables rules which and enable rules which
  * Enable IP masquerading
  * Enable a basic firewall with the ability to open specified inbound TCP/UDP ports
 * udev aliasing of the interfaces to the names `wan` and `lan`

## Installation

Just clone the repository or copy the state files into /srv/salt/masquerade.

Put `masquerade` into includes in your top.sls state file.

Let me know if you know a better way to provide reusable states!


## Configuration

Local configuration is done with pillar data, see the example below.

### Example configuration

```yaml
network:
  dns_domain: foobar.com
  lan:
    ip: 192.168.27.1
    mac_address: 68:15:cd:13:19:ed
    dhcp_range: [192.168.27.10, 192.168.27.200]
    ethers:
      B8:27:E3:34:e9:2a: somemachine
      00:26:b3:db:ef:7a: someothermachine
      00:26:b3:0a:e5:3a: athirdmachine

  wan:
    mac_address: a1:b2:cb:88:11:21
    open_ports: [22, 80]
```
