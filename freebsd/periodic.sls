{%- from "freebsd/map.jinja" import freebsd with context %}

{{ freebsd.periodic.file }}:
  file.managed:
    - source: salt://freebsd/files/periodic.conf.local
    - template: jinja
    - user: root
    - group: wheel
    - mode: 0444
