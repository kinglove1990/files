#!/bin/ash

# 查找包含 PARTNAME=data 的 mmcblk0 分区
data_mmcblk=$(grep -rn PARTNAME /sys/block/mmcblk0 | grep -w data | cut -d '/' -f 5)

# 创建挂载点
mkdir -p /mnt/data

# 解密分区并映射为 /dev/mapper/data
cryptsetup --key-file=/lib/mmc/data_key luksOpen /dev/$data_mmcblk data

# 挂载解密后的分区到 /mnt/data
mount /dev/mapper/data /mnt/data
