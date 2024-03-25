
## Command

```shell
oc get policy -A -o=custom-columns=NS:.metadata.namespace,NAME:.metadata.name,"REMEDIATION ACTION":.spec.remediationAction,"COMPLIANCE STATE":.status.compliant,WAVE:.metadata.annotations."ran\.openshift\.io\/ztp-deploy-wave" --sort-by={.metadata.annotations."ran\.openshift\.io\/ztp-deploy-wave"}
```

## Example

```shell
# oc get policy -A -o=custom-columns=NS:.metadata.namespace,NAME:.metadata.name,"REMEDIATION ACTION":.spec.remediationAction,"COMPLIANCE STATE":.status.compliant,WAVE:.metadata.annotations."ran\.openshift\.io\/ztp-deploy-wave" --sort-by={.metadata.annotations."ran\.openshift\.io\/ztp-deploy-wave"}
NS       NAME                                                REMEDIATION ACTION   COMPLIANCE STATE   WAVE
sno146   ztp-policy-414.414-config-catalog-policy            inform               Compliant          1
sno146   ztp-policy-common.vdu-common-config-policy          inform               Compliant          1
sno146   ztp-policy-common.vdu-common-subscriptions-policy   inform               NonCompliant       2
sno146   ztp-policy-414.414-config-config-policy             inform               Compliant          10
sno146   ztp-policy-common.vdu-common-network-policy         inform               Compliant          10
```