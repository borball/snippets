function ocp-kernel-version {
  local ocp_version=$1
  if [[ -z "${ocp_version}" ]]; then
    echo "Usage: ${FUNCNAME} <ocp_version>"
    return -1
  fi

  pull_secret=${HOME}/cluster/pull-secret.json
  if [[ ! -f ${pull_secret} ]]; then
    echo "Pull secret (${pull_secret}) doesn't exists"
    return -1
  fi
  os_image=$(oc adm release info ${ocp_version} --image-for rhel-coreos-extensions)
  if [[ -z ${os_image} ]]; then
    echo "Unable to determin os image for openshift version ${ocp_version}"
    echo "Only works for release 4.14+"
    return -1
  fi
  echo "Inspect ${ocp_version}/rhel-coreos-extensions ${os_image}"
  oc image extract --registry-config ${pull_secret} $os_image --dry-run |grep kernel-rt-core
}
