#!/system/bin/sh
cd "${0%/*}"

# DNS
FILE=/etc/resolv.conf

if [ -f "$FILE" ]; then
    if cat $FILE | grep "8.8.8.8" > /dev/null; then
        :
    else
        echo "nameserver 8.8.8.8" >> $FILE
        echo "已为您添加 Google DNS 配置，建议重启设备后再次执行此脚本。"
    fi
    if cat $FILE | grep "114.114.114.114" > /dev/null; then
        :
    else
        echo "nameserver 114.114.114.114" >> $FILE
        echo "已为您添加 114 DNS 配置，建议重启设备后再次执行此脚本。"
    fi
else
    echo "nameserver 8.8.8.8" >> $FILE
    echo "nameserver 114.114.114.114" >> $FILE
    chmod 0644 $FILE
    echo "您的设备此前没有正确的 resolv.conf 配置，已为您自动配置，请重启设备后再次执行此脚本。"
fi


# Core
./clash/clash -d ./clash >> /dev/null 2>&1 &
#./tiny/tiny -c ./tiny/*.conf
#./redsocks2/redsocks2 -c ./redsocks2/*.conf 2>&1 &
#./overture/overture -c ./overture/*.yml >/dev/null 2>&1 &
./v2ray/v2ray -config ./v2ray/*.json >> /dev/null 2>&1 &


