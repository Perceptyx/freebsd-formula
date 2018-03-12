# FreeBSD Formula

A saltstack formula that configures FreeBSD Systems.


## Available states

- [`audit`](#audit)
- [`newsyslog`](#newsyslog)
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

### Newsyslog

- Manage newsyslog additional configurations

```yml
freebsd:
  newsyslog:
    enabled: true
    newsyslog_include_conf: "/etc/newsyslog.conf.d"
    configs:
      my_app:
        log: '/var/log/my_app.log'
        owner: 'root:wheel'
        mode: '644'
        count: '7'
        size: '*'
        when: '@T00'
        flags: 'JBN'
        pid_file: ''
        sig_num: ''
      nginx:
        log: '/var/log/nginx/*.log'
        owner: ''
        mode: '644'
        count: '30'
        size: '100'
        when: '*'
        flags: 'JB'
        pid_file: '/var/run/nginx.pid'
        sig_num: '30'
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
  repositories:
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
