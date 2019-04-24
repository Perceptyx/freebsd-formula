{%- from "freebsd/map.jinja" import freebsd with context %}

# Only apply loader.conf settings if we are not inside a jail
{%- if grains['virtual_subtype'] is not defined or grains['virtual_subtype'] is defined and grains['virtual_subtype'] != 'jail' %}

{%- for key, value in pillar.freebsd.loader.get('settings', {}).iteritems() %}

freebsd_loader_conf_{{ key }}:
  sysctl.present:
    - name: {{ key }}
    - value: {{ value }}
    - config: /boot/loader.conf

{%- endfor %}

{%- endif %}
