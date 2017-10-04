{%- from "freebsd/map.jinja" import freebsd with context %}

audit_service:
  service.running:
    - name: auditd
    - enable: True

{%- if pillar.freebsd.audit.control is defined %}
/etc/security/audit_control:
  file.managed:
    - source: salt://freebsd/files/audit_control
    - template: jinja
    - user: root
    - group: wheel
    - mode: 0444
    - watch_in:
      - service: audit_service
{% endif %}

{%- if pillar.freebsd.audit.users is defined %}
/etc/security/audit_user:
  file.managed:
    - source: salt://freebsd/files/audit_user
    - template: jinja
    - user: root
    - group: wheel
    - mode: 0444
    - watch_in:
      - service: audit_service
{% endif %}
