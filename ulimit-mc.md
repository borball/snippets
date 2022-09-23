How to use MachineConfig to modify ulimits on OpenShift

- Update ulimits on the host

```shell
cat << EOF | base64 -w0
* hard memlock unlimited
* soft memlock unlimited
* hard rtprio 100
* soft rtprio 100
EOF

KiBoYXJkIG1lbWxvY2sgdW5saW1pdGVkCiogc29mdCBtZW1sb2NrIHVubGltaXRlZAoqIGhhcmQgcnRwcmlvIDEwMAoqIHNvZnQgcnRwcmlvIDEwMAo
```

```yaml
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata: 
  labels: 
    machineconfiguration.openshift.io/role: master
  name: 02-master-ulimit-host
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
          source: data:text/plain;charset=utf-8;base64,KiBoYXJkIG1lbWxvY2sgdW5saW1pdGVkCiogc29mdCBtZW1sb2NrIHVubGltaXRlZAoqIGhhcmQgcnRwcmlvIDEwMAoqIHNvZnQgcnRwcmlvIDEwMAo=
          verification: {}
        group: {}
        mode: 420
        path: /etc/security/limits.d/custom.conf
        user: {}
```

- Update ulimits in the pods

```shell
cat << EOF | base64 -w0
[crio.runtime]
default_ulimits = [
"memlock=-1:-1",
"rtprio=100:100"
]
EOF

W2NyaW8ucnVudGltZV0KZGVmYXVsdF91bGltaXRzID0gWwoibWVtbG9jaz0tMTotMSIsCiJydHByaW89MTAwOjEwMCIKXQo=
```

```yaml
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  annotations:
  labels:
    machineconfiguration.openshift.io/role: master
  name: 02-master-ulimit-container-runtime
spec:
  config:
    ignition:
      version: 3.2.0
    storage:
      files:
      - contents:
          source: data:text/plain;charset=utf-8;base64,W2NyaW8ucnVudGltZV0KZGVmYXVsdF91bGltaXRzID0gWwoibWVtbG9jaz0tMTotMSIsCiJydHByaW89MTAwOjEwMCIKXQo=
        mode: 420
        overwrite: true
        path: /etc/crio/crio.conf.d/10-custom
```
