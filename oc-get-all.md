## Alias

```shell
alias ocgetall='oc api-resources --verbs=list --namespaced -o name | xargs -t -n 1 oc get --show-kind --ignore-not-found 2>/dev/null'
```

## Example 1

```shell
# ocgetall -n sno146
NAME                                 DATA   AGE
configmap/kube-root-ca.crt           1      28d
configmap/openshift-service-ca.crt   1      28d
LAST SEEN   TYPE     REASON               OBJECT                                                     MESSAGE
3m35s       Normal   PolicyTemplateSync   policy/ztp-policy-414.414-config-catalog-policy            Policy template 414-config-catalog-policy-config was updated successfully
4m2s        Normal   PolicyTemplateSync   policy/ztp-policy-414.414-config-config-policy             Policy template 414-config-config-policy-config was updated successfully
4m2s        Normal   PolicyTemplateSync   policy/ztp-policy-common.vdu-common-config-policy          Policy template vdu-common-config-policy-config was updated successfully
4m2s        Normal   PolicyTemplateSync   policy/ztp-policy-common.vdu-common-network-policy         Policy template vdu-common-network-policy-config was updated successfully
2m40s       Normal   PolicyTemplateSync   policy/ztp-policy-common.vdu-common-subscriptions-policy   Policy template vdu-common-subscriptions-policy-config was updated successfully
NAME                              TYPE                                  DATA   AGE
secret/builder-dockercfg-rltp5    kubernetes.io/dockercfg               1      28d
secret/builder-token-dpqq6        kubernetes.io/service-account-token   4      28d
secret/default-dockercfg-ldpkc    kubernetes.io/dockercfg               1      28d
secret/default-token-xdn8c        kubernetes.io/service-account-token   4      28d
secret/deployer-dockercfg-xxlcn   kubernetes.io/dockercfg               1      28d
secret/deployer-token-zt5jh       kubernetes.io/service-account-token   4      28d
NAME                      SECRETS   AGE
serviceaccount/builder    1         28d
serviceaccount/default    1         28d
serviceaccount/deployer   1         28d
NAME                                                                                         ROLE                                                         USERS   GROUPS                          SERVICE ACCOUNTS                                                     USERS
rolebinding.authorization.openshift.io/open-cluster-management:governance-policy-framework   sno146/open-cluster-management:governance-policy-framework                                           open-cluster-management-agent-addon/governance-policy-framework-sa
rolebinding.authorization.openshift.io/system:deployers                                      /system:deployer                                                                                     deployer
rolebinding.authorization.openshift.io/system:image-builders                                 /system:image-builder                                                                                builder
rolebinding.authorization.openshift.io/system:image-pullers                                  /system:image-puller                                                 system:serviceaccounts:sno146
NAME
role.authorization.openshift.io/open-cluster-management:governance-policy-framework
LAST SEEN   TYPE     REASON               OBJECT                                                     MESSAGE
3m38s       Normal   PolicyTemplateSync   policy/ztp-policy-414.414-config-catalog-policy            Policy template 414-config-catalog-policy-config was updated successfully
4m5s        Normal   PolicyTemplateSync   policy/ztp-policy-414.414-config-config-policy             Policy template 414-config-config-policy-config was updated successfully
4m5s        Normal   PolicyTemplateSync   policy/ztp-policy-common.vdu-common-config-policy          Policy template vdu-common-config-policy-config was updated successfully
4m5s        Normal   PolicyTemplateSync   policy/ztp-policy-common.vdu-common-network-policy         Policy template vdu-common-network-policy-config was updated successfully
2m43s       Normal   PolicyTemplateSync   policy/ztp-policy-common.vdu-common-subscriptions-policy   Policy template vdu-common-subscriptions-policy-config was updated successfully
NAME                                                                                         CATALOG                         AGE
packagemanifest.packages.operators.coreos.com/cryostat-operator                              disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/smart-gateway-operator                         disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhtas-operator                                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/odr-cluster-operator                           disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/volsync-product                                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/run-once-duration-override-operator            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/apicast-operator                               disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/nfd                                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/odf-multicluster-orchestrator                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/lvms-operator                                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/devspaces                                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/mcg-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/serverless-operator                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/3scale-operator                                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/jws-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/ocs-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/clusterresourceoverride                        disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/kiali-ossm                                     disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/numaresources-operator                         disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/datagrid                                       disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/amq7-interconnect-operator                     disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/netobserv-operator                             disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/deployment-validation-operator                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/web-terminal                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/vertical-pod-autoscaler                        disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/odf-csi-addons-operator                        disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/elasticsearch-operator                         disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/openshift-cert-manager-operator                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/cluster-logging                                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/ansible-automation-platform-operator           disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/metallb-operator                               disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/jaeger-product                                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/logic-operator-rhel8                           disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/quay-operator                                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/local-storage-operator                         disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/eap                                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/authorino-operator                             disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/advanced-cluster-management                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/aws-load-balancer-operator                     disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/cincinnati-operator                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/mtr-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/ingress-node-firewall                          disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/ansible-cloud-addons-operator                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/ocs-client-operator                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/fuse-apicurito                                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/node-healthcheck-operator                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/kubevirt-hyperconverged                        disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhods-prometheus-operator                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/gatekeeper-operator-product                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/openshift-custom-metrics-autoscaler-operator   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/fuse-online                                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/secrets-store-csi-driver-operator              disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/quay-bridge-operator                           disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/skupper-operator                               disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/security-profiles-operator                     disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/amq-online                                     disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhsso-operator                                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/compliance-operator                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/servicemeshoperator                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/machine-deletion-remediation                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/amq-streams                                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/ptp-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/service-telemetry-operator                     disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/costmanagement-metrics-operator                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/openshift-builds-operator                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhacs-operator                                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhbk-operator                                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/bare-metal-event-relay                         disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/service-registry-operator                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/odr-hub-operator                               disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/submariner                                     disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/amq-broker-rhel8                               disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/openshift-gitops-operator                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/tang-operator                                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/windows-machine-config-operator                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/bamoe-kogito-operator                          disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/opentelemetry-product                          disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/openshift-pipelines-operator-rh                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhods-operator                                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/mtv-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/mta-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/tempo-product                                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/bamoe-businessautomation-operator              disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/aws-efs-csi-driver-operator                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhpam-kogito-operator                          disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/fuse-console                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/node-maintenance-operator                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/loki-operator                                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/multicluster-global-hub-operator-rh            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/businessautomation-operator                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rhdh                                           disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/self-node-remediation                          disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/kernel-module-management                       disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/cluster-observability-operator                 disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/power-monitoring-operator                      disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/kubernetes-nmstate-operator                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/rh-service-binding-operator                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/sriov-network-operator                         disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/sandboxed-containers-operator                  disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/mtc-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/external-dns-operator                          disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/dpu-network-operator                           disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/odf-operator                                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/klusterlet-product                             disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/red-hat-camel-k                                disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/topology-aware-lifecycle-manager               disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/file-integrity-operator                        disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/devworkspace-operator                          disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/fence-agents-remediation                       disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/openshift-secondary-scheduler-operator         disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/gcp-filestore-csi-driver-operator              disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/node-observability-operator                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/red-hat-hawtio-operator                        disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/container-security-operator                    disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/cluster-kube-descheduler-operator              disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/kernel-module-management-hub                   disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/multicluster-engine                            disconnected-redhat-operators   28d
packagemanifest.packages.operators.coreos.com/redhat-oadp-operator                           disconnected-redhat-operators   28d
NAME                                                                                           COMPLIANCE STATE
configurationpolicy.policy.open-cluster-management.io/414-config-catalog-policy-config         Compliant
configurationpolicy.policy.open-cluster-management.io/414-config-config-policy-config          Compliant
configurationpolicy.policy.open-cluster-management.io/vdu-common-config-policy-config          Compliant
configurationpolicy.policy.open-cluster-management.io/vdu-common-network-policy-config         Compliant
configurationpolicy.policy.open-cluster-management.io/vdu-common-subscriptions-policy-config   NonCompliant
NAME                                                                                         REMEDIATION ACTION   COMPLIANCE STATE   AGE
policy.policy.open-cluster-management.io/ztp-policy-414.414-config-catalog-policy            inform               Compliant          28d
policy.policy.open-cluster-management.io/ztp-policy-414.414-config-config-policy             inform               Compliant          28d
policy.policy.open-cluster-management.io/ztp-policy-common.vdu-common-config-policy          inform               Compliant          28d
policy.policy.open-cluster-management.io/ztp-policy-common.vdu-common-network-policy         inform               Compliant          28d
policy.policy.open-cluster-management.io/ztp-policy-common.vdu-common-subscriptions-policy   inform               NonCompliant       28d
NAME                                                                                        ROLE                                                       AGE
rolebinding.rbac.authorization.k8s.io/open-cluster-management:governance-policy-framework   Role/open-cluster-management:governance-policy-framework   28d
rolebinding.rbac.authorization.k8s.io/system:deployers                                      ClusterRole/system:deployer                                28d
rolebinding.rbac.authorization.k8s.io/system:image-builders                                 ClusterRole/system:image-builder                           28d
rolebinding.rbac.authorization.k8s.io/system:image-pullers                                  ClusterRole/system:image-puller                            28d
NAME                                                                                 CREATED AT
role.rbac.authorization.k8s.io/open-cluster-management:governance-policy-framework   2024-02-26T18:45:27Z
```

## Example 2

```shell
ocgetall -A
```

## Example 3

```shell
ocgetall -n <ns> -o yaml |grep -C10 etcd
```