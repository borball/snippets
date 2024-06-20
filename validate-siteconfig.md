Alias to validate the siteConfig format:

```shell
alias validate-siteconfig-4.14='podman run -it -v `pwd`/:/resources:Z,U registry.redhat.io/openshift4/ztp-site-generate-rhel8:v4.14 generator install’
alias validate-siteconfig-4.15='podman run -it -v `pwd`/:/resources:Z,U registry.redhat.io/openshift4/ztp-site-generate-rhel8:v4.15 generator install’
alias validate-siteconfig-4.16='podman run -it -v `pwd`/:/resources:Z,U quay.io/openshift-kni/ztp-site-generator:4.16 generator install’
```

```shell
# validate-siteconfig-4.14 mno.yaml
Processing SiteConfigs: /resources/mno.yaml
Generating installation CRs into /resources/out/generated_installCRs ...

# validate-siteconfig-4.15 mno.yaml
Processing SiteConfigs: /resources/mno.yaml
Generating installation CRs into /resources/out/generated_installCRs ...

# validate-siteconfig-4.16 mno.yaml
Processing SiteConfigs: /resources/mno.yaml
Generating installation CRs into /resources/out/generated_installCRs ...
```