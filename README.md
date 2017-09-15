# FreeBSD Formula 

A saltstack formula that configures FreeBSD Systems.


## Available states

- [`periodic`](#periodic)


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
