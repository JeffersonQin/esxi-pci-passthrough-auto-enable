#!/bin/sh ++group=host/vim/vmvisor/boot

# local configuration options

# Note: modify at your own risk!  If you do/use anything in this
# script that is not part of a stable API (relying on files to be in
# specific places, specific tools, specific output, etc) there is a
# possibility you will end up with a broken system after patching or
# upgrading.  Changes are not supported unless under direction of
# VMware support.

# Note: This script will not be run when UEFI secure boot is enabled.

esxcli hardware pci pcipassthru set -a -e FALSE -d $(esxcli hardware pci list | grep 2070 -B 7 | grep Address | sed 's/\s*Address:\s*//')
esxcli hardware pci pcipassthru set -a -e TRUE -d $(esxcli hardware pci list | grep 2070 -B 7 | grep Address | sed 's/\s*Address:\s*//')

exit 0
