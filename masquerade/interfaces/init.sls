#!stateconf


/etc/network/interfaces:
  file.managed:
    - source: salt://{{ sls_dir }}/interfaces/interfaces
    - template: jinja

service networking restart:
  cmd.wait:
    - watch:
      - file: /etc/network/interfaces


/etc/udev/rules.d/70-persistent-net.rules:
  file.managed:
    - mode: 600
    - source: salt://{{ sls_dir }}/interfaces/udev_persistent-net.rules
    - template: jinja

