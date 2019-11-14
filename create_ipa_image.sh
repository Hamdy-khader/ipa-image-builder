#!/bin/bash
 
export DIB_DEV_USER_USERNAME=devuser
export DIB_DEV_USER_PASSWORD=devuser
export DIB_DEV_USER_PWDLESS_SUDO=yes
export DIB_MLNX_OFED_REPO_FILE=https://linux.mellanox.com/public/repo/mlnx_ofed/latest/rhel7.6/mellanox_mlnx_ofed.repo
export DIB_MLNX_OFED_PKGLIST='dkms ibacm ibutils ibverbs-utils infiniband-diags libibcm libibcommon libibmad libibumad libibverbs libibverbs-runtime libmlx4 libmlx4-dev libmlx5 librdmacm librdmacm-dev librdmacm-runtime mstflint opensm pciutils perftest qperf rdma rpm-build srptools vlan'
 
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)
IMAGE_NAME=$SCRIPT_DIR/ironic-deploy
export ELEMENTS_PATH=$SCRIPT_DIR/stackhpc-image-elements/elements/:$SCRIPT_DIR/ironic-python-agent-builder/dib/
 
 
# check distro to get package manager
if [[ ! -z $(which yum) ]]; then
PACKAGE_MANAGER='yum'
elif [[ ! -z $(which apt-get) ]]; then
PACKAGE_MANAGER='apt-get'
else
echo "error can't find commands: 'yum' or 'apt-get'"
exit 1;
fi
 
 
# install deps
$PACKAGE_MANAGER install python-pip -y
pip install diskimage-builder
 
 
# cloning the required elements
if [ ! -d "$SCRIPT_DIR/stackhpc-image-elements" ]; then
git clone https://github.com/stackhpc/stackhpc-image-elements.git
fi
if [ ! -d "$SCRIPT_DIR/ironic-python-agent-builder" ]; then
git clone https://opendev.org/openstack/ironic-python-agent-builder.git
fi
 
# building the image
disk-image-create deploy-baremetal mellanox devuser ironic-python-agent-ramdisk centos7 dhcp-all-interfaces mlnx-ofed disable-selinux hwdiscovery -o $IMAGE_NAME
