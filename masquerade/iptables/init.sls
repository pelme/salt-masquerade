#!stateconf

# Turn on Source Address Verification on all interfaces to
# prevent some spoofing attacks
net.ipv4.conf.default.rp_filter:
  sysctl.present:
    - value: "1"

net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - value: "1"

net.ipv4.tcp_syncookies:
  sysctl.present:
    - value: "1"

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

iptables-persistent:
  pkg.installed


service iptables-persistent restart:
  cmd.wait:
    - require:
      - pkg: iptables-persistent
    - watch:
      - file: /etc/iptables/*

/etc/iptables/rules.v4:
  file.managed:
    - mode: 600
    - source: salt://{{ sls_dir }}/iptables/rules.v4
    - template: jinja
