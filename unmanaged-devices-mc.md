## How to put network devices as unmanaged 

### MachineConfig

```shell
cat << EOF | base64 -w0
[keyfile]
unmanaged-devices=interface-name:ens1f1;interface-name:ens1f2;interface-name:ens1f3;interface-name:ens1f4;interface-name:ens2f0;interface-name:ens2f1;interface-name:ens2f2;interface-name:ens2f3
EOF

W2tleWZpbGVdCnVubWFuYWdlZC1kZXZpY2VzPWludGVyZmFjZS1uYW1lOmVuczFmMTtpbnRlcmZhY2UtbmFtZTplbnMxZjI7aW50ZXJmYWNlLW5hbWU6ZW5zMWYzO2ludGVyZmFjZS1uYW1lOmVuczFmNDtpbnRlcmZhY2UtbmFtZTplbnMyZjA7aW50ZXJmYWNlLW5hbWU6ZW5zMmYxO2ludGVyZmFjZS1uYW1lOmVuczJmMjtpbnRlcmZhY2UtbmFtZTplbnMyZjMK
```


```yaml
---
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: master
  name: 99-master-unmanaged-devices
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
          source: data:text/plain;charset=utf-8;base64,W2tleWZpbGVdCnVubWFuYWdlZC1kZXZpY2VzPWludGVyZmFjZS1uYW1lOmVuczFmMTtpbnRlcmZhY2UtbmFtZTplbnMxZjI7aW50ZXJmYWNlLW5hbWU6ZW5zMWYzO2ludGVyZmFjZS1uYW1lOmVuczFmNDtpbnRlcmZhY2UtbmFtZTplbnMyZjA7aW50ZXJmYWNlLW5hbWU6ZW5zMmYxO2ludGVyZmFjZS1uYW1lOmVuczJmMjtpbnRlcmZhY2UtbmFtZTplbnMyZjMK
          verification: {}
        group: {}
        mode: 0420
        path: /etc/NetworkManager/conf.d/99-unmanaged-devices.conf
        user: {}
```

### Test

On the node:

```bash

[core@sno146 ~]$ sudo cat /etc/NetworkManager/conf.d/99-unmanaged-devices.conf
[keyfile]
unmanaged-devices=interface-name:ens1f1;interface-name:ens1f2;interface-name:ens1f3;interface-name:ens1f4;interface-name:ens2f0;interface-name:ens2f1;interface-name:ens2f2;interface-name:ens2f3

[core@sno146 ~]$ nmcli device status |grep ens
ens1f0                                             ethernet       connected                              ovs-if-phys0
ens1f0                                             ovs-port       connected                              ovs-port-phys0
ens1f1                                             ethernet       unmanaged                              --
ens1f2                                             ethernet       unmanaged                              --
ens1f3                                             ethernet       unmanaged                              --
ens2f0                                             ethernet       unmanaged                              --
ens2f1                                             ethernet       unmanaged                              --
ens2f2                                             ethernet       unmanaged                              --
ens2f3                                             ethernet       unmanaged                              --

```

