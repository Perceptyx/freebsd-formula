{% from "freebsd/macros.jinja" import configure_interface with context -%}

{% if salt['pillar.get']('freebsd:networking', False) %}
include:
  - freebsd.kernel

{% set networking = salt['pillar.get']('freebsd:networking') %}

{% if networking.gateway is defined %}
freebsd_networking_gateway:
  sysrc.managed:
    - name: gateway_enable
    - value: "YES"
    - onchanges_in:
      - cmd: freebsd_networking_restart
{% endif %} {# if networking.gateway is defined #}

{% if networking.defaultrouter is defined %}
freebsd_networking_defaultrouter:
  sysrc.managed:
    - name: defaultrouter
    - value: "{{ networking.defaultrouter }}"
    - onchanges_in:
      - cmd: freebsd_networking_restart
{% endif %} {# if networking.defaultrouter is defined #}

{% if networking.dns.nameservers is defined %}
freebsd_networking_dns_config:
  sysrc.managed:
    - name: resolvconf
    - value: "NO"
    - require_in:
      - file: freebsd_networking_dns_config
  file.managed:
    - name: /etc/resolv.conf
    - mode: 0644
    - owner: root
    - group: wheel
    - contents:
      {% if networking.dns.search is defined %}
        - search {{ " ".join(networking.dns.search) }}
      {% endif %}
      {% for dns in networking.dns.nameservers %}
        - nameserver {{ dns }}
      {% endfor %}
    - require:
      - cmd: freebsd_networking_restart
{% endif %} {# if networking.defaultrouter is defined #}

{#---------- CLONED INTERFACES ----------#}
{% if networking.interfaces.cloned_interfaces is defined %}
{% set cloned_interfaces = networking.interfaces.cloned_interfaces|join(" ") %}

cloned_interfaces:
  sysrc.managed:
    - value: "{{ cloned_interfaces|lower }}"
    - onchanges_in:
      - cmd: freebsd_networking_restart

{% for interface in networking.interfaces.cloned_interfaces %}
{% set interface_cfg = salt['pillar.get']('freebsd:networking:interfaces:cloned_interfaces:' ~ interface ) %}
{% if interface_cfg.protocol is defined and interface_cfg.ports is defined %}
{{ configure_interface(interface, None, interface_cfg.protocol, interface_cfg.ports) }}
{% endif %}

{% if interface_cfg.aliases is defined %}
{% for alias in interface_cfg.aliases %}
{{ configure_interface(interface ~ "_alias" ~ loop.index0, alias) }}
{% endfor %} {# for alias in interface_cfg.aliases #}
{% endif %} {# if interface_cfg.aliases is defined #}

{% endfor %} {# for interface in networking.interfaces.cloned_interfaces #}
{% endif %} {# if networking.interfaces.cloned_interfaces is defined #}

{#---------- REGULAR INTERFACES ----------#}
{% for interface in networking.interfaces if not interface.startswith('cloned_interfaces') %}
{% set interface_cfg = salt['pillar.get']('freebsd:networking:interfaces:' ~ interface ) %}

{% if interface_cfg.aliases is defined %}
{# We need to configure the parent interface as UP #}
{{ configure_interface(interface) }}
{% for alias in interface_cfg.aliases %}
{{ configure_interface(interface ~ "_alias" ~ loop.index0, alias) }}
{% endfor %} {# for alias in interface_cfg.aliases #}
{% else %}
{{ configure_interface(interface, interface_cfg) }}
{% endif %} {# if interface_cfg.aliases is defined #}

{% endfor %} {# for interface in networking.interfaces #}

{% endif %} {# if salt['pillar.get']('freebsd:networking', False) #}

freebsd_networking_restart:
  cmd.run:
    - name: |
        exec 0>&- # close stdin
        exec 1>&- # close stdout
        exec 2>&- # close stderr
        nohup /bin/sh -c '/etc/rc.d/routing restart && /etc/rc.d/netif restart' &
    - timeout: 60
    - ignore_timeout: True
    - require:
      {# Make sure we have all needed kernel modules (i.e if_lagg) loaded #}
      - sls: freebsd.kernel
