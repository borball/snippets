## Install

```shell

#upload the kernel-tools and kernel-tools-libs rpm to /tmp folder 
cd /tmp
sudo rpm-ostree install --cache-only kernel-tools-*.rpm
sudo systemctl reboot
#After reboot:
sudo turbostat
```
## upgrade

```shell

#upload the kernel-tools and kernel-tools-libs rpm to /tmp folder 
cd /tmp
sudo rpm-ostree upgrade --cache-only --uninstall kernel-tools-libs-5.14.0-284.64.1.el9_2.x86_64 --uninstall kernel-tools-5.14.0-284.64.1.el9_2.x86_64 --install kernel-tools-5.14.0-284.66.1.el9_2.x86_64.rpm --install kernel-tools-libs-5.14.0-284.66.1.el9_2.x86_64.rpm
sudo systemctl reboot
```

Example:

```shell

[root@sno130 tmp]# rpm-ostree upgrade --cache-only --uninstall kernel-tools-libs-5.14.0-284.64.1.el9_2.x86_64 --uninstall kernel-tools-5.14.0-284.64.1.el9_2.x86_64 --install kernel-tools-5.14.0-284.66.1.el9_2.x86_64.rpm --install kernel-tools-libs-5.14.0-284.66.1.el9_2.x86_64.rpm
Pulling manifest: ostree-unverified-image:docker://quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:5b661952b113f439dffc23ba4a8815f003fd01808fda78c56b26e4438f5f4ea4
Checking out tree 545b4a9... done
Resolving dependencies... done
Applying 5 overrides and 7 overlays
Processing packages... done
Running pre scripts... done
Running post scripts... done
Running posttrans scripts... done
Writing rpmdb... done
Generating initramfs... done
Writing OSTree commit... done
Staging deployment... done
Upgraded:
kernel-tools 5.14.0-284.64.1.el9_2 -> 5.14.0-284.66.1.el9_2
kernel-tools-libs 5.14.0-284.64.1.el9_2 -> 5.14.0-284.66.1.el9_2
Run "systemctl reboot" to start a reboot
[root@sno130 tmp]# systemctl reboot
[root@sno130 tmp]# Connection to 192.168.14.29 closed by remote host.
Connection to 192.168.14.29 closed.

```