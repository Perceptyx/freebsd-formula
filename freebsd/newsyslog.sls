{%- from "freebsd/map.jinja" import freebsd with context %}

{% for name, args in salt['pillar.get']('freebsd:newsyslog:configs', {}).iteritems() %}

{{ freebsd.newsyslog.newsyslog_include_conf }}/{{ name }}:
  file.managed:
    - source: salt://freebsd/files/newsyslog_conf
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
    - context:
        log: "{{ args.log }}"
        owner: "{{ args.owner }}"
        mode: "{{ args.mode }}"
        count: {{ args.count }}
        size: "{{ args.size }}"
        when: "{{ args.when }}"
        flags: "{{ args.flags }}"
        pid_file: "{{ args.pid_file }}"
        sig_num: "{{ args.sig_num }}"

{% endfor %}
