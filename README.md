# ESXi PCI Device Passthrough Fix

Solve the problem that the PCI devices' passthrough deactivates after reboot on ESXi, and it is also hard to reset due to UI flickering.

The bug still presents on ESXi 8.0 Update 1, and here is the solution.

## Solution

Edit `/etc/rc.local.d/local.sh` using `vi` in ESXi shell after enabling SSH. Add the following two lines before `exit 0`,

```bash
esxcli hardware pci pcipassthru set -a -e FALSE -d $(esxcli hardware pci list | grep 2070 -B 7 | grep Address | sed 's/\s*Address:\s*//')
esxcli hardware pci pcipassthru set -a -e TRUE -d $(esxcli hardware pci list | grep 2070 -B 7 | grep Address | sed 's/\s*Address:\s*//')
```

Here, modify `2070` to the pattern of device name you want to match. I am using `2070` because I want to passthrough Nvidia RTX 2070 Super.

Also, if there is a device group, you only need to choose one of the device (may be the main device?). Here I choose `TU104 [GeForce RTX 2070 SUPER]` for the whole group

```
TU104 [GeForce RTX 2070 SUPER]
TU104 HD Audio Controller
TU104 USB 3.1 Host Controller
TU104 USB Type-C UCSI Controller
```

Essentially it first disable the passthrough, then enable it again everytime the esxi boots, because after reboot it may says that "the passthrough is enabled but a reboot is needed," which leads to an endless loop of rebooting on your end.

This scripts tends to be the solution to this problem.

Also, see `local.sh` for the script after modification.
