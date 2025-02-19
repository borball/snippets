## Method 1

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


## Method 2

### Script

```shell
#!/bin/bash

turn_off_lldp_agent() {
  local _net_name=$1

  if [[ ! -d /sys/class/net/${_net_name}/device/ ]]; then
    echo "WARNING: no device found in /sys/class/net/${_net_name}/device/"
    return
  fi
  local _vendor_id=$(cat /sys/class/net/${_net_name}/device/vendor)
  local _device_id=$(cat /sys/class/net/${_net_name}/device/device)

  if [[ "$_vendor_id" != 0x8086 ]] || [[ "$_device_id" != "0x1593" ]]; then
    echo "WARNING: device ${_net_name} [vendor($_vendor_id):device($_device_id)] does not match target NIC [0x8086:0x1593]"
    return
  fi
  local _lldp_agent=$(ethtool --show-priv-flags ${_net_name} |grep fw-lldp-agent|cut -d : -f 2|tr -d "[:blank:]")
  if [[ "$_lldp_agent" == "on" ]]; then
    ethtool --set-priv-flags ${_net_name} fw-lldp-agent off
    _lldp_agent=$(ethtool --show-priv-flags ${_net_name} |grep fw-lldp-agent|cut -d : -f 2|tr -d "[:blank:]")
    echo "NOTICE: changed device ${_net_name} fw-lldp-agent to ${_lldp_agent}"
  else
    echo "INFO: no change needed for device ${_net_name} fw-lldp-agent: ${_lldp_agent}"
  fi
}

for pci_device in $(ls -d /sys/bus/pci/drivers/ice/0000:*); do
  turn_off_lldp_agent $(ls -1 $pci_device/net)
done
```


### MachineConfig

```yaml

apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: master
  name: turnoff-intel-e810-lldp-agent
spec:
  config:
    ignition:
      version: 3.2.0
    storage:
      files:
      - contents:
          compression: gzip
          source: data:;base64,H4sIACnitWcCA71UTW+cMBC98ytmHQ5QCXm3VauUaA9R1FZ7IVIVqQeEkBcPH4pjr7B3kyrsf68N24Wttml6CReD/ebN85sZLmZ03Ui6Zrr2PLNtZa7KMheCb3JWoTRBCM8egFAFE5BLNLlkD7j0F57dbUpIU5hBxIHqn5oWgmlNLYj6z0fsnnLcNQVSyLIrMDVKGwmARa2A/Lj+nqySbzFIBQMMSrWVHBr5GkrSU7XohNvXshml7lBy1eYNX/pBwcxr2IaQcOQY9v+LY1jC0R3ij1IIzJYwf7qcX36yZkDXHQDHPD2AzJ8WHz9/IC/6dTBrKgHSIVEwyRjGAzCYJAkz4Aq1tdzAAzNFDYa1FRpIVjeQDvLiQUP2gsFjj1h30NRGKQFRpGv1GG3aZheVglX6VGFXtbiB8jFywVEf3BVb4xoohqiE951p3QdJ47Vg8j7OSDh1csxJYGmdUvJPl0YdaP4q40QA2IbvY9/yRr/rmdzerW6+xFDUTFbIz5b1VK1R7nSUunclQqFxwrpKvt72IzXQgkTklrxU7b8TxGfobdn3nufCN0VzaCQ3oX4g9HH411tN7THl1ilsNXXTMLdP/C68sg1nac78Xg4UC/BHZjdboceVRO8Xycm2q54EAAA=[kube:admin@vduhw40-exilis/pBwcxr2IaQcOQY9v+LY1jC0R3ij1IIzJYwf7qcX36yZkDXHQDHPD2AzJ8WHz9/IC/6dTBrKgHSIVEwyRjGAzCYJAkz4Aq1tdzAAzNFDYa1FRpIVjeQDvLiQUP2gsFjj1h30NRGKQFRpGv1GG3aZheVglX6VGFXtbiB8jFywVEf3BVb4xoohqiE951p3QdJ47Vg8j7OSDh1csxJYGmdUvJPl0YdaP4q40QA2IbvY9/yRr/rmdzerW6+xFDUTFbIz5b1VK1R7nSUunclQqFxwrpKvt72IzXQgkTklrxU7b8TxGfobdn3nufCN0VzaCQ3oX4g9HH411tN7THl1ilsNXXTMLdP/C68sg1nac78Xg4UC/BHZjdboceVRO8Xycm2q54EAAA=
          verification: {}
        filesystem: root
        mode: 493
        path: /var/usrlocal/bin/turnoff-intel-e810-lldp-agent.sh
    systemd:
      units:
      - contents: |
          [Unit]
          After=ovs-configuration.service
          Before=crio.service

          [Service]
          Type=oneshot
          RemainAfterExit=yes
          ExecStart=/var/usrlocal/bin/turnoff-intel-e810-lldp-agent.sh

          [Install]
          WantedBy=multi-user.target
        enabled: true
        name: turnoff-intel-e810-lldp-agent.service
```
