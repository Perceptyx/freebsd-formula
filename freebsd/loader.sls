{% set memtotal = grains['mem_total'] %}
{% set zfs_arc_max_percentage = salt['pillar.get']('freebsd:loader:zfs:arc_max_percentage', 15) %}
{% set zfs_arc_max_hard_limit = salt['pillar.get']('freebsd:loader:zfs:arc_max_hard_limit', 2048) %}
{% set zfs_arc_max = (memtotal / 100 * zfs_arc_max_percentage) | round | int %}
{% if zfs_arc_max >= zfs_arc_max_hard_limit %}
{% set zfs_arc_max = zfs_arc_max_hard_limit %}
{% endif %}

zfs_arc_max:
  file.replace:
    - name: /boot/loader.conf
    - pattern: ^vfs\.zfs\.arc_max\=.*$
    - repl: vfs.zfs.arc_max="{{ zfs_arc_max }}M"
    - append_if_not_found: True

