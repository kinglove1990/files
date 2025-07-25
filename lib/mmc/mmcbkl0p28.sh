#‌创建挂载点目录

mkdir /mnt/mmcblk0p28

#挂载设备

mount /dev/mmcblk0p28 /mnt/mmcblk0p28

#‌切换工作目录

cd /overlay

#拷贝overlay分区文件到P28分区

cp -r /overlay/* /mnt/mmcblk0p28

#检查是否拷贝成功，输入下面的命令回车看到 lost+found upper work文件夹，说明拷贝成功。

ls /mnt/mmcblk0p28

#生成挂载文件

block detect > /etc/config/fstab

#把p28分区挂载到overlay

sed -i s#/mnt/mmcblk0p28#/overlay# /etc/config/fstab

#把原来的overlay挂载取消

sed -i '13s/1/0/g' /etc/config/fstab

#最后的最后就是输入reboot后重启就可以

reboot
