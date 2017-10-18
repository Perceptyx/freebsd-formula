# FreeBSD Formula

A saltstack formula that configures FreeBSD Systems.


## Available states

- [`audit`](#audit)
- [`periodic`](#periodic)
- [`repositories`](#repositories)
- [`sysctl`](#sysctl)

### Audit

- Manage auditd service and configuration

```yml
freebsd:
  audit:
    enabled: true
    control:
      dir: "/var/audit"
      dist: "off"
      flags: "lo,aa"
      minfree: "5"
      naflags: "lo,aa"
      policy: "cnt,argv"
      filesz: "2M"
      expire-after: "10M"
    users:
      root: "lo:no"
```

### Periodic

- Configure how daily, weekly and monthly system maintenance jobs should run

```yml
freebsd:
  periodic:
    enabled: true
    file: "/etc/periodic.conf.local"
    options:
      daily_output: "/var/log/daily.log"
      weekly_output: "/var/log/weekly.log"
      monthly_output: "/var/log/monthly.log"
```

### Repositories

- Manage custom repositories configuration

```yml
freebsd:
  repositoires:
    area51:
      url: "http://meatwad.mouf.net/rubick/poudriere/packages/110-amd64-kde/"
      enabled: true
      mirror_type: "http"
      priority: 2
```

### Sysctl

- Manage kernel state

```yml
freebsd:
  sysctl:
    enabled: true
    settings:
      net.inet.ip.portrange.first: 20000
      kern.coredump: 0
      kern.ipc.somaxconn: 1024
```
