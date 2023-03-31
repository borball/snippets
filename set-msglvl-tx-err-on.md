### MachineConfig

```shell
cat << EOF | base64 -w0
#!/usr/bin/env bash

ethtool -s ens1f1 msglvl tx_err on
ethtool -s ens1f2 msglvl tx_err on
ethtool -s ens1f3 msglvl tx_err on
EOF

IyEvdXNyL2Jpbi9lbnYgYmFzaAoKc3VkbyBldGh0b29sIC1zIGVuczFmMSBtc2dsdmwgdHhfZXJyIG9uCnN1ZG8gZXRodG9vbCAtcyBlbnMxZjIgbXNnbHZsIHR4X2VyciBvbgpzdWRvIGV0aHRvb2wgLXMgZW5zMWYzIG1zZ2x2bCB0eF9lcnIgb24K

```

```yaml

---
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: master
  name: 99-master-set-ice-tx-trace
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
            source: data:text/plain;charset=utf-8;base64,IyEvdXNyL2Jpbi9lbnYgYmFzaAoKc3VkbyBldGh0b29sIC1zIGVuczFmMSBtc2dsdmwgdHhfZXJyIG9uCnN1ZG8gZXRodG9vbCAtcyBlbnMxZjIgbXNnbHZsIHR4X2VyciBvbgpzdWRvIGV0aHRvb2wgLXMgZW5zMWYzIG1zZ2x2bCB0eF9lcnIgb24K
            verification: {}
          group: {}
          mode: 0550
          path: /usr/local/bin/set-ice-tx-trace.sh
          user: {}
    systemd:
      units:
        - contents: |
            [Unit]
            Description==Set ICE TX Trace

            [Service]
            Type=oneshot
            ExecStart=/usr/local/bin/set-ice-tx-trace.sh

            [Install]
            WantedBy=multi-user.target
          enabled: true
          name: set-ice-tx-trace.service

```
