# {%- if freebsd is defined %}
# include:
# {%- if freebsd.periodic.enabled %}
#   - freebsd.periodic
# {%- endif %}
# {%- endif %}

{%- if pillar.freebsd is defined %}
include:
{%- if pillar.freebsd.audit.enabled %}
  - freebsd.audit
{%- endif %}
{%- if pillar.freebsd.periodic.enabled %}
  - freebsd.periodic
{%- endif %}
{%- if pillar.freebsd.repositories %}
  - freebsd.repositories
{%- endif %}
{%- if pillar.freebsd.sysctl.enabled %}
  - freebsd.sysctl
{%- endif %}
{%- endif %}
