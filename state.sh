#!/system/bin/sh

module="clash overture redsocks2 tiny v2ray"

cd "${0%/*}"

echo "Friendship is Magic!"
echo ""

for u in $module; do
    if [[ `ps | grep -i $u` != "" ]]; then
        echo " ● 已启用 $u"
    else
        echo " ○ 已停用 $u"
    fi
    echo ""
done

echo "→ nat ←"
iptables -t nat -S OUTPUT
echo ""
iptables -t nat -S PREROUTING
echo ""
echo "→ mangle ←"
iptables -t mangle -S OUTPUT
echo ""
iptables -t mangle -S FORWARD
