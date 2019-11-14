# MOFED Image Builder

- create_ipa_image.sh

The script will build IPA images (ironic-deploy.initramfs, ironic-deploy.kernel) from base image CentOS7 then install MOFED and ironic ptthon agent



- create_baremetal_image.sh

The script will build baremetal image (baremetal-image.qcow2) from base image CentOS7 then install MOFED

# References
* https://github.com/stackhpc/stackhpc-image-elements
* https://www.mellanox.com/page/mlnx_ofed_public_repository
* https://opendev.org/openstack/diskimage-builder/
* https://opendev.org/openstack/ironic-python-agent-builder/
* https://docs.openstack.org/ironic-python-agent-builder/latest/admin/dib.html
* https://docs.openstack.org/ironic-python-agent/latest/install/index.html#image-builders
