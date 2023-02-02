## How to modify kube-controller-manager argument terminated-pod-gc-threshold

In some cases the pods may be evicted and the terminated pods remained in [ContainerStatusUnknown](https://github.com/kubernetes/kubernetes/issues/105467) state. Until Pod garbage collector [(PodGC)]([https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-garbage-collection) gets involved or a human or controller process explicitly removes them, the terminated pod objects will be remained in the cluster's API.

The Pod garbage collector (PodGC) cleans up terminated Pods (with a phase of Succeeded or Failed), when the number of Pods exceeds the configured threshold (determined by terminated-pod-gc-threshold in the kube-controller-manager).

Following is the procedure to modify the terminated-pod-gc-threshold in the kube-controller-manager on OpenShift.

```
oc patch KubeControllerManager cluster --type merge -p '{"spec": {"unsupportedConfigOverrides":{"extendedArguments": {"terminated-pod-gc-threshold": ["120"]}}}}'
```

kube-controller-manager pod will be recreated, and check logs:

```
oc logs -f -n openshift-kube-controller-manager kube-controller-manager-sno148.outbound.vz.bos2.lab |grep  PodGC

I0124 19:13:13.342672       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-kube-controller-manager/revision-pruner-12-sno148.outbound.vz.bos2.lab
I0124 19:13:13.342956       1 gc_controller.go:78] PodGC is force deleting Pod: assisted-installer/assisted-installer-controller--1-52mqs
I0124 19:13:13.343027       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-etcd/installer-2-sno148.outbound.vz.bos2.lab
I0124 19:13:13.343074       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-kube-scheduler/installer-3-sno148.outbound.vz.bos2.lab
I0124 19:13:13.343100       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-b26jd
I0124 19:13:13.343171       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-kube-scheduler/installer-6-sno148.outbound.vz.bos2.lab
I0124 19:13:13.343198       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-f5wl9
I0124 19:13:13.343243       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-bjj5j
I0124 19:13:13.343283       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-kube-scheduler/revision-pruner-6-sno148.outbound.vz.bos2.lab
I0124 19:13:13.343126       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-kzdp8
I0124 19:13:13.343299       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-n6pld
I0124 19:13:13.343138       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-dv4db
I0124 19:13:13.343389       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-mmgwv
I0124 19:13:13.343445       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-marketplace/2b0dd4166e068816d5983d56f737940b378b601a9fdcc1516f7672--1-w8mhj
I0124 19:13:13.343493       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-qtv6d
I0124 19:13:13.343509       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-lksd5
I0124 19:13:13.343494       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-kqcw8
I0124 19:13:13.343391       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-marketplace/35bf84980eae616415d313c531c679e41675267a04ae718fdcc880--1-fc7p8
I0124 19:13:13.343512       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-vwtrz
I0124 19:13:13.343446       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-bj8qz
I0124 19:13:13.343146       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-wpdms
I0124 19:13:13.343151       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-kube-scheduler/installer-4-sno148.outbound.vz.bos2.lab
I0124 19:13:13.343155       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-kfv7c
I0124 19:13:13.343160       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-kube-scheduler/installer-5-sno148.outbound.vz.bos2.lab
I0124 19:13:13.343290       1 gc_controller.go:78] PodGC is force deleting Pod: default/bad-deployment-5d574d6c9f-srlpx
I0124 19:13:13.343340       1 gc_controller.go:78] PodGC is force deleting Pod: openshift-kube-controller-manager/revision-pruner-8-sno148.outbound.vz.bos2.lab
```