{%- from "freebsd/map.jinja" import freebsd with context %}

{%- if pillar.freebsd is defined %}
include:
{%- if pillar.freebsd.audit.enabled %}
  - freebsd.audit
{%- endif %}
{%- if pillar.freebsd.newsyslog.enabled %}
  - freebsd.newsyslog
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
{%- if pillar.freebsd.kernel.enabled %}
  - freebsd.kernel
{%- endif %}
{%- endif %}
