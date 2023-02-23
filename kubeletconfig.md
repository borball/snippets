## How to update kubelet config with PerformanceProfile on OpenShift

We can update kubelet config with KubeletConfig CR, this can also be done through PerformanceProfile

```
apiVersion: performance.openshift.io/v2
kind: PerformanceProfile
metadata:
  annotations:
    kubeletconfig.experimental: |
      {"maxPods": 500,"systemReserved":{"memory":"2.5Gi"},"kubeReserved":{"memory":"2Gi"}}
...
```

Refer to [kubelet-config](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/) to get more info.