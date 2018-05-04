{%- from "freebsd/map.jinja" import freebsd with context %}

# Only load kernel modules if we are not inside a jail
{%- if grains['virtual_subtype'] is not defined or grains['virtual_subtype'] is defined and grains['virtual_subtype'] != 'jail' %}

{%- for module in pillar.freebsd.kernel.get('modules', []) %}

freebsd_kernel_{{ module }}:
  kmod.present:
    - name: {{ module }}
    - persist: true

{%- endfor %}

{%- endif %}
