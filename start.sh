#!/system/bin/sh

#目标转发端口
DPORT="10807"

#DNS转发端口
DNS=""

#禁网，注意UID 1000需要禁网
UID1="1000"

#绕过非TCP协议
UID2=""

#绕过所有协议
UID3=""

#共享放行其它协议，填任意字符放行
GX=""

################################
cd "${0%/*}"
./stop.sh nostate
sleep 0.1
./start-core.sh
iptables -t mangle -P OUTPUT ACCEPT

iptables -t mangle -I OUTPUT -p tcp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t mangle -I OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t mangle -I OUTPUT -o wlan+ -j ACCEPT
iptables -t mangle -I OUTPUT -o tun+ -j ACCEPT
iptables -t mangle -I OUTPUT -o lo -j ACCEPT

if [[ $DNS != "" ]]; then
    iptables -t nat -I OUTPUT -p udp -m owner ! --uid-owner 0 --dport 53 -j DNAT --to-des $DNS
    echo ""
else
    #iptables -t nat -I OUTPUT -p udp -m owner ! --uid-owner 0 --dport 53 -j REDIRECT --to 1053
    :
fi

iptables -t nat -I OUTPUT -p tcp -m owner ! --uid-owner 0 -j REDIRECT --to $DPORT
iptables -t nat -I OUTPUT -o wlan+ -j ACCEPT
iptables -t nat -I OUTPUT -o tun+ -j ACCEPT
iptables -t nat -I OUTPUT -o lo -j ACCEPT
iptables -t mangle -P FORWARD DROP
#iptables -t nat -I PREROUTING -s 192.168/16 -p tcp ! -d 192.168/16 -j REDIRECT --to 10807
iptables -t nat -I PREROUTING -s 192.168/16 -p tcp ! -d 192.168/16 -j REDIRECT --to $DPORT

if [[ $UID1 != "" ]]; then
    for J in $UID1; do
        iptables -t mangle -I OUTPUT -m owner --uid-owner $J -j DROP
    done
fi

if [[ $UID2 != "" ]]; then
    for J in $UID2; do
        iptables -t mangle -I OUTPUT -m owner --uid-owner $J -j ACCEPT
    done
fi

if [[ $UID3 != "" ]]; then
    for J in $UID3; do
        iptables -t mangle -I OUTPUT -m owner --uid-owner $J -j ACCEPT
        iptables -t nat -I OUTPUT -m owner --uid-owner $J -j ACCEPT
    done
fi

if [[ $GX != "" ]]; then
    iptables -t mangle -P FORWARD ACCEPT
fi

./state.sh
