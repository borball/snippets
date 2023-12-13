alias ocgetall='oc api-resources --verbs=list --namespaced -o name | xargs -t -n 1 oc get --show-kind --ignore-not-found 2>/dev/null'

ocgetall -A -o yaml |grep -C20 192.168.158.15
