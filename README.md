# FreeBSD Formula

A saltstack formula that configures FreeBSD Systems.


## Available states

- [`periodic`](#periodic)
- [`repositories`](#repositories)

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
