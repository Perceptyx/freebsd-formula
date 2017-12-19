{%- from "freebsd/map.jinja" import freebsd with context %}

{% for repo, args in salt['pillar.get']('freebsd:repositories', {}).iteritems() %}

{{ repo }}-config:
  file.managed:
    - name: {{ freebsd.repositories_dir }}/{{ repo }}.conf
    - source: salt://freebsd/files/repo.conf
    - template: jinja
    - owner: root
    - group: wheel
    - mode: 644
    - context:
        name: {{ repo }}
        url: {{ args.url }}
        enabled: {{ args.enabled }}
        mirror_type: {{ args.mirror_type }}
        priority: {{ args.priority }}

repository-{{ repo }}-update:
  cmd.run:
    - name: pkg update -f
    - onchanges:
      - file: {{ repo }}-config

{% endfor %}
