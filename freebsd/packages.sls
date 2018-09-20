{%- set packages = salt['pillar.get']('freebsd:packages') %}

include:
  - freebsd.repositories

{%- if packages.installed is defined %}
{%- for package in packages.installed %}
freebsd_packages_installed_{{ package }}:
  pkg.installed:
    - name: {{ package }}
    - require:
      - sls: freebsd.repositories
{%- endfor %}
{%- endif %} {# if packages.installed is defined #}

{%- if packages.latest is defined %}
{%- for package in packages.latest %}
freebsd_packages_latest_{{ package }}:
  pkg.latest:
    - name: {{ package }}
    - require:
      - sls: freebsd.repositories
{%- endfor %}
{%- endif %} {# if packages.latest is defined #}

{%- if packages.absent is defined %}
{%- for package in packages.absent %}
freebsd_packages_absent_{{ package }}:
  pkg.removed:
    - name: {{ package }}
    - require:
      - sls: freebsd.repositories
{%- endfor %}
{%- endif %} {# if packages.absent is defined #}

{%- if packages.custom is defined %}
{%- for package, options in packages.custom.items() %}
freebsd_packages_custom_{{ package }}:
  pkg.{{ options.status }}:
    - name: {{ package }}
    - fromrepo: {{ options.repository }}
    - require:
      - sls: freebsd.repositories
{%- endfor %}
{%- endif %} {# if packages.custom is defined #}
