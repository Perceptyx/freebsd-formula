{%- from "freebsd/map.jinja" import freebsd with context %}

{%- if pillar.freebsd is defined %}
include:
  {%- if pillar.freebsd.audit is defined %}
  - freebsd.audit
  {%- endif %}
  {%- if pillar.freebsd.kernel is defined %}
  - freebsd.kernel
  {%- endif %}
  {%- if pillar.freebsd.networking is defined %}
  - freebsd.networking
  {%- endif %}
  {%- if pillar.freebsd.newsyslog is defined %}
  - freebsd.newsyslog
  {%- endif %}
  {%- if pillar.freebsd.periodic is defined %}
  - freebsd.periodic
  {%- endif %}
  {%- if pillar.freebsd.repositories is defined %}
  - freebsd.repositories
  {%- endif %}
  {%- if pillar.freebsd.sysctl is defined %}
  - freebsd.sysctl
  {%- endif %}
{%- endif %} {# if pillar.freebsd is defined #}
