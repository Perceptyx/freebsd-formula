{%- from "freebsd/map.jinja" import freebsd with context %}


{%- for sysctl_name, sysctl_value in pillar.freebsd.sysctl.get('settings', {}).iteritems() %}

freebsd_kernel_{{ sysctl_name }}:
  sysctl.present:
    - name: {{ sysctl_name }}
    - value: {{ sysctl_value }}

{%- endfor %}
