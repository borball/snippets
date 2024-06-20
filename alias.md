```shell
alias ocgetall='oc api-resources --verbs=list --namespaced -o name | xargs -t -n 1 oc get --show-kind --ignore-not-found 2>/dev/null'

ocgetall -A -o yaml |grep -C20 192.168.158.15

alias validate-siteconfig-4.14=‘podman run -it -v `pwd`/:/resources:Z,U registry.redhat.io/openshift4/ztp-site-generate-rhel8:v4.14 generator install’
alias validate-siteconfig-4.15=‘podman run -it -v `pwd`/:/resources:Z,U registry.redhat.io/openshift4/ztp-site-generate-rhel8:v4.15 generator install’
alias validate-siteconfig-4.16=‘podman run -it -v `pwd`/:/resources:Z,U quay.io/openshift-kni/ztp-site-generator:4.16 generator install’

```
