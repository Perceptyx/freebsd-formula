# {%- if freebsd is defined %}
# include:
# {%- if freebsd.periodic.enabled %}
#   - freebsd.periodic
# {%- endif %}
# {%- endif %}

{%- if pillar.freebsd is defined %}
include:
{%- if pillar.freebsd.periodic.enabled %}
  - freebsd.periodic
{%- endif %}
{%- if pillar.freebsd.repositories %}
  - freebsd.repositories
{%- endif %}
{%- endif %}
