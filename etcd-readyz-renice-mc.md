## How to use MachineConfig to renice etcd readyz container

### MachineConfig

```shell
cat << EOF | base64 -w0
#!/usr/bin/env bash

ls /proc/$(pgrep -f 'cluster-etcd-operator readyz')/task | xargs renice -10
EOF

IyEvdXNyL2Jpbi9lbnYgYmFzaAoKbHMgL3Byb2MvJChwZ3JlcCAtZiAnY2x1c3Rlci1ldGNkLW9wZXJhdG9yIHJlYWR5eicpL3Rhc2sgfCB4YXJncyByZW5pY2UgLTEw
```


```yaml
---
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata: 
  labels: 
    machineconfiguration.openshift.io/role: master
  name: 02-master-etcd-readyz-renice
spec: 
  config:
    ignition: 
      config: 
        replace: 
          verification: {}
      proxy: {}
      security: 
        tls: {}
      timeouts: {}
      version: 3.2.0
    passwd: {}
    storage:
      files: 
      - contents: 
          source: data:text/plain;charset=utf-8;base64,IyEvdXNyL2Jpbi9lbnYgYmFzaAoKbHMgL3Byb2MvJChwZ3JlcCAtZiAnY2x1c3Rlci1ldGNkLW9wZXJhdG9yIHJlYWR5eicpL3Rhc2sgfCB4YXJncyByZW5pY2UgLTEw
          verification: {}
        group: {}
        mode: 0550
        path: /usr/local/bin/etcd-readyz-renice.sh
        user: {}
    systemd:
     units:   
     - contents: |
         [Unit]
         Description=Renice etcd readyz container

         [Timer]
         OnBootSec=5min
         OnUnitActiveSec=5min

         [Install]
         WantedBy=multi-user.target
       enabled: true
       name: etcd-renice.timer
     - contents: |
         [Unit]
         Description==Renice etcd readyz container(to be called by a timer)

         [Service]
         Type=simple
         ExecStart=/usr/local/bin/etcd-readyz-renice.sh
       name: etcd-renice.service
```

### Test

On the node:

```bash

[core@sno147 ~]$ systemctl list-timers
NEXT                         LEFT          LAST                         PASSED  UNIT                         ACTIVATES
Fri 2022-09-30 18:50:00 UTC  18s left      n/a                          n/a     chronyd-restart.timer        chronyd-restart.serv>
Fri 2022-09-30 18:54:34 UTC  4min 53s left Fri 2022-09-30 18:49:34 UTC  6s ago  etcd-renice.timer            etcd-renice.service
Fri 2022-09-30 18:59:31 UTC  9min left     n/a                          n/a     systemd-tmpfiles-clean.timer systemd-tmpfiles-cle>
Sat 2022-10-01 00:00:00 UTC  5h 10min left Fri 2022-09-30 00:00:00 UTC  18h ago logrotate.timer              logrotate.service
Sat 2022-10-01 00:00:00 UTC  5h 10min left Fri 2022-09-30 00:00:00 UTC  18h ago unbound-anchor.timer         unbound-anchor.servi>


[core@sno147 ~]$ systemctl status etcd-renice.service
● etcd-renice.service - =Renice etcd readyz container(to be called by a timer)
   Loaded: loaded (/etc/systemd/system/etcd-renice.service; static; vendor preset: disabled)
   Active: inactive (dead) since Fri 2022-09-30 18:49:34 UTC; 22s ago
  Process: 131524 ExecStart=/usr/local/bin/etcd-readyz-renice.sh (code=exited, status=0/SUCCESS)
 Main PID: 131524 (code=exited, status=0/SUCCESS)
      CPU: 46ms

Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 42554 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 42555 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 42556 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 42557 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 42558 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 42564 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 42565 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab etcd-readyz-renice.sh[131524]: 43637 (process ID) old priority 0, new priority -10
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab systemd[1]: etcd-renice.service: Succeeded.
Sep 30 18:49:34 sno147.outbound.vz.bos2.lab systemd[1]: etcd-renice.service: Consumed 46ms CPU time


```

