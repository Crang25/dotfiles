## 1. Boot from the NixOS Live USB(use text-based iso)

## 2. Identify Your Partitions
You need to find the identifiers for:

- Your NixOS root partition (e.g., /dev/nvme0n1p2 or /dev/sda2)
- Your EFI System Partition (ESP) (e.g., /dev/nvme0n1p1 or /dev/sda1)

Use the lsblk or fdisk command to list your disks and partitions:
```
lsblk -f
# or
sudo fdisk -l
```
#### Look at the output. You are looking for:
A partition with a **FAT32** filesystem and a label like **EFI**, **SYSTEM**, or **ESP**. This is your **EFI** partition. Note its device name.
A partition with a **ext4**, **btrfs**, or **zfs** filesystem. This is likely your NixOS root partition. Note its device name.

## 3. Mount Your NixOS Installation
- Mount the root partition (replace /dev/sda2 with your actual partition):
```sudo mount /dev/sda2 /mnt```

- Mount the boot/EFI partition (replace /dev/sda1 with your actual EFI partition):
```
sudo mount /dev/sda1 /mnt/boot
```

- Mount necessary filesystems:
```
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
```

- Enter your NixOS system with Chroot:
```
sudo chroot /mnt
```
OR
- Use nixos-enter (simpler than manual chroot) if chroot does not work:
```
sudo nixos-enter --root /mnt
```

- Reinstall/update the bootloader:
```
nixos-rebuild boot

```

## 4 Reboot
```
exit
umount -R /mnt
reboot
```
