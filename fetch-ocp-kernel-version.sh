
for i in {25..44}; do
  os_image=$(oc adm release info 4.14.${i} --image-for rhel-coreos-extensions)
  mkdir -p /run/mco-machine-os-content/os-content/4.14.${i}
  oc image extract --path /usr/share/rpm-ostree/extensions:/run/mco-machine-os-content/os-content/4.14.${i} --registry-config ~/pull-secret.json $os_image
  ls /run/mco-machine-os-content/os-content/4.14.${i}/extensions/kernel-rt-core*
  rm -rf /run/mco-machine-os-content/os-content/4.14.${i}
done
