#!/system/bin/sh

module="clash overture redsocks2 tiny v2ray"

cd "${0%/*}"

for u in $module; do
    pkill $u
    sleep 0.01
    pkill $u
done

iptables -t mangle -P OUTPUT ACCEPT
iptables -t mangle -F OUTPUT
iptables -t mangle -P FORWARD ACCEPT
iptables -t mangle -F FORWARD
iptables -t nat -F OUTPUT
iptables -t nat -F PREROUTING

if [[ ! -n "$1" ]]; then
    ./state.sh
fi
