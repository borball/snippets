### MachineConfig

Will use ens[1-2]f[0-3] as en example, can change this based on your lab situation:

```shell
cat << EOF | base64 -w0
#!/usr/bin/env bash

for i in ens1f0 ens1f1 ens1f2 ens1f3 ens2f0 ens2f1 ens2f2 ens2f3; do
  ethtool --set-priv-flags \$i fw-lldp-agent off
done
EOF

IyEvdXNyL2Jpbi9lbnYgYmFzaAoKZm9yIGkgaW4gZW5zMWYwIGVuczFmMSBlbnMxZjIgZW5zMWYzIGVuczJmMCBlbnMyZjEgZW5zMmYyIGVuczJmMzsgZG8KICBldGh0b29sIC0tc2V0LXByaXYtZmxhZ3MgJGkgZnctbGxkcC1hZ2VudCBvZmYKZG9uZQo=

```

```yaml
---
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: master
  name: 99-master-disable-lldp-agent
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
            source: data:text/plain;charset=utf-8;base64,IyEvdXNyL2Jpbi9lbnYgYmFzaAoKZm9yIGkgaW4gZW5zMWYwIGVuczFmMSBlbnMxZjIgZW5zMWYzIGVuczJmMCBlbnMyZjEgZW5zMmYyIGVuczJmMzsgZG8KICBldGh0b29sIC0tc2V0LXByaXYtZmxhZ3MgJGkgZnctbGxkcC1hZ2VudCBvZmYKZG9uZQo=
            verification: {}
          group: {}
          mode: 0550
          path: /usr/local/bin/disable-lldp-agent.sh
          user: {}
    systemd:
      units:
        - contents: |
            [Unit]
            Description==Disable LLDP agent

            [Service]
            Type=oneshot
            ExecStart=/usr/local/bin/disable-lldp-agent.sh

            [Install]
            WantedBy=multi-user.target
          enabled: true
          name: disable-lldp-agent.service

```
