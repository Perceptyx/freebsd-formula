# FreeBSD Formula

A saltstack formula that configures FreeBSD Systems.


## Available states

- [`audit`](#audit)
- [`kernel`](#kernel)
- [`networking`](#networking)
- [`newsyslog`](#newsyslog)
- [`periodic`](#periodic)
- [`repositories`](#repositories)
- [`sysctl`](#sysctl)
- [`loader`](#loader)

### Audit

- Manage auditd service and configuration

```yml
freebsd:
  audit:
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

### Kernel

- Manage kernel modules

```yml
freebsd:
  kernel:
    modules:
      - pfsync
      - carp
      - if_lagg
```

### Networking

- Manage network interfaces configuration

```yml
freebsd:
  networking:
    # Makes the server to act as a gateway
    gateway: True
    # Sets the server default router / default gateway
    #defaultrouter: 10.0.0.1
    dns:
      nameservers:
        - 8.8.8.8
        - 8.8.4.4
      search:
        - perceptyx.com
        - domain.com
    interfaces:
      em0: dhcp
      em1:
        aliases:
          - 1.2.3.4 netmask 255.255.255.0
          - 5.6.7.8/32
      cloned_interfaces:
        lagg0:
          protocol: failover
          ports:
            - em2
            - em3
          aliases:
            - 9.10.11.12/32
            - 13.14.15.16 netmask 255.255.255.240
```

### Newsyslog

- Manage newsyslog additional configurations

```yml
freebsd:
  newsyslog:
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

### Packages

- Install and remove packages, specifying repository if needed

```yml
freebsd:
  packages:
    installed:
      - nginx
    latest:
      - bash
    absent:
      - virtualbox-ose-additions-nox11
    custom:
      docbook:
        status: installed
        repository: saltstack
      gettext-tools:
        status: latest
        repository: saltstack
```

### Periodic

- Configure how daily, weekly and monthly system maintenance jobs should run

```yml
freebsd:
  periodic:
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
    settings:
      net.inet.ip.portrange.first: 20000
      kern.coredump: 0
      kern.ipc.somaxconn: 1024
```

### Loader

- Manage settings added to `/boot/loader.conf`

```yaml
freebsd:
  loader:
    settings:
      vfs.zfs.arc_max: 2048
```
