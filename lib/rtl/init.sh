#!/bin/ash

# 设置库文件的链接（如果需要的话）
cp /lib/libubus.so.* /lib/libubus.so
cp /lib/libubox.so.* /lib/libubox.so

# 创建设备文件的符号链接
ln -s /dev/spidev1.0 /dev/spidev32765.0

# 设置命名管道
control_fifo=/tmp/control_rtl9303.fifo
mkfifo $control_fifo

# 启动后台应用程序
tail -f $control_fifo | /lib/rtl/usrApp &
APP_PID=$!

# 等待后台程序初始化
sleep 30

# 发送控制命令（如果需要的话）
# echo "port set port all state disable" > $control_fifo

# 发送退出命令
echo "exit" > $control_fifo

# 等待后台程序退出
wait $APP_PID
