#!stateconf

dnsmasq-pkg:
  pkg.installed:
    - name: dnsmasq

dnsmasq-service:
  service.running:
    - name: dnsmasq
    - enable: True
    - require:
      - pkg: dnsmasq
    - watch:
      - file: /etc/dnsmasq.conf
      - file: /etc/hosts
      - file: /etc/ethers

/etc/dnsmasq.conf:
  file.managed:
    - source: salt://{{ sls_dir }}/dnsmasq//dnsmasq.conf
    - template: jinja
    - mode: 600
    - require:
      - pkg: dnsmasq

/etc/hosts:
  file.managed:
    - source: salt://{{ sls_dir }}/dnsmasq/hosts
    - template: jinja
    - mode: 644

/etc/ethers:
  file.managed:
    - source: salt://{{ sls_dir }}/dnsmasq/ethers
    - template: jinja
    - mode: 644
