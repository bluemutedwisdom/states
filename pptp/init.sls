include:
  - bind
  - sysctl

pptpd:
  pkg:
    - installed
  service.running:
    - enabled: True
    - watch:
      - file: pptpd
      - file: pptpd-secrets
      - file: pptpd-options
  file.managed:
    - name: /etc/pptpd.conf
    - source: salt://pptp/pptpd.conf
    - template: jinja
    - require:
      - pkg: pptpd

pptpd-secrets:
  file.managed:
    - name: /etc/ppp/chap-secrets
    - mode: 600
    - source: salt://pptp/chap-secrets
    - template: jinja

pptpd-options:
  file.managed:
    - name: /etc/ppp/options
    - template: jinja
    - source: salt://pptp/options
