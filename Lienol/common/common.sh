#!/bin/bash

##############加载自定义app################
git clone https://github.com/fw876/helloworld.git package/openwrt-packages/luci-app-ssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-packages/luci-app-passwall
git clone https://github.com/vernesong/OpenClash.git package/openwrt-packages/OpenClash

git clone https://github.com/Leo-Jo-My/luci-theme-opentomato.git package/openwrt-packages/luci-theme-opentomato
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/openwrt-packages/luci-theme-rosy
svn co https://github.com/apollo-ng/luci-theme-darkmatter/trunk/luci package/openwrt-packages/luci-theme-darkmatter

git clone https://github.com/jerrykuku/node-request.git package/openwrt-packages/node-request
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/openwrt-packages/luci-app-jd-dailybonus
git clone https://github.com/jefferymvp/luci-app-koolproxyR package/openwrt-packages/luci-app-koolproxyR

svn co https://github.com/garypang13/openwrt-packages/trunk/luci-app-serverchan package/openwrt-packages/luci-app-serverchan
svn co https://github.com/garypang13/openwrt-packages/trunk/luci-app-aliddns package/openwrt-packages/luci-app-aliddns

svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/openwrt-packages/luci-app-eqos

##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a

#getversion(){
#ver=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/$1/releases/latest) | grep -o -E "[0-9].+")
#[ $ver ] && echo $ver || git ls-remote --tags git://github.com/$1 | cut -d/ -f3- | sort -t. -nk1,2 -k3 | awk '/^[^{]*$/{version=$1}END{print version}' | grep -o -E "[0-9].+"
#}
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion AdguardTeam/AdGuardHome)/g" package/openwrt-packages/adguardhome/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/g" package/openwrt-packages/adguardhome/Makefile
#sed -i "s/LUCI_DEPENDS:=.*/LUCI_DEPENDS:=+ca-certs +curl +wget +PACKAGE_$(PKG_NAME)_INCLUDE_binary:AdGuardHome/g" package/openwrt-packages/luci-app-adguardhome/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改默认wifi名称ssid为iMei
sed -i 's/ssid=OpenWrt/ssid=iMei/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改默认wifi密码key为12345678
#sed -i 's/key=password/key=12345678/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

sed -i '/msgid "Hostnames"/{n;s/主机名/主机映射/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/base >> feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '13s/40/45/g' package/diy/luci-app-dockerman/luasrc/controller/dockerman.lua

sed -i 's/44/43/g' package/lean/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' package/lean/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/NAS/Services/g' package/lean/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/网络存储/存储/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po

sed -i '/msgid "miniDLNA"/{n;s/miniDLNA/DLNA服务/;}' feeds/luci/applications/luci-app-minidlna/po/zh-cn/minidlna.po

sed -i 's/IP\/MAC绑定/地址绑定/g' package/lean/luci-app-arpbind/po/zh-cn/arpbind.po

sed -i 's/"ZeroTier"/"内网穿透"/g' package/lean/luci-app-zerotier/luasrc/controller/zerotier.lua

sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-diag-core/po/zh-cn/diag_core.po
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-mwan3/po/zh-cn/mwan3.po

sed -i 's/Lienol"/Master"/g' feeds/luci/luci.mk

sed -i '48,51d' package/default-settings/files/zzz-default-settings
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
#sed -i "s/'OpenWrt SNAPSHOT '/'OpenWrt SNAPSHOT $date Build By imei '/g" package/default-settings/files/zzz-default-settings

sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/lienol/luci-app-socat/po/zh-cn/socat.po

sed -i 's/BaiduPCS Web/百度网盘/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
sed -i 's/services/nas/g'  `package/lean/luci-app-baidupcs-web/luasrc`

echo -e "\nmsgid \"qBittorrent\"" >> package/lean/luci-app-qbittorrent/po/zh-cn/qbittorrent.po
echo -e "msgstr \"BT  下载\"" >> package/lean/luci-app-qbittorrent/po/zh-cn/qbittorrent.po

sed -i 's/aMule设置/电驴下载/g' package/lean/luci-app-amule/po/zh-cn/amule.po
sed -i 's/网络存储/存储/g' package/lean/luci-app-amule/po/zh-cn/amule.po

sed -i 's/可道云/可道云盘/g' package/lean/luci-app-kodexplorer/po/zh-cn/kodexplorer.po

sed -i 's/88/89/g' package/lean/luci-app-autoreboot/luasrc/controller/autoreboot.lua

sed -i 's/90/89/g' feeds/luci/applications/luci-app-watchcat/luasrc/controller/watchcat.lua

sed -i 's/89/88/g' package/lean/luci-app-filetransfer/luasrc/controller/filetransfer.lua

sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po

sed -i 's/TTYD 终端/命令终端/g' feeds/luci/transplant/luci-app-ttyd/po/zh-cn/terminal.po

sed -i 's/解锁网易云灰色歌曲/网易音乐/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/services/vpn/g'  `grep services -rl package/lean/luci-app-unblockmusic/luasrc`

sed -i 's/上网时间控制/时间控制/g' feeds/lienol/luci-app-timecontrol/po/zh-cn/timecontrol.po

sed -i 's/Tcpdump 流量监控/流量监控/g' package/diy/luci-app-tcpdump/po/zh-cn/tcpdump.po

sed -i 's/network/control/g'  `grep network -rl package/diy/OpenAppFilter/luci-app-oaf/luasrc`

sed -i 's/network/control/g'  `package/openwrt-packages/luci-app-eqos/luasrc/controller/eqos.lua`

sed -i 's/CPU 性能优化调节/CPU 调节/g' package/lean/luci-app-cpufreq/po/zh-cn/cpufreq.po

sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po

sed -i 's/services/system/g'  `grep services -rl feeds/luci/applications/luci-app-watchcat/luasrc`
sed -i '50s/WatchCat/智能重启/g' feeds/luci/applications/luci-app-watchcat/po/zh-cn/watchcat.po
sed -i '17s/Reboot on internet connection lost/互联网连接丢失时重启/g' feeds/luci/applications/luci-app-watchcat/luasrc/model/cbi/watchcat/watchcat.lua
sed -i '18s/Periodic reboot/定期重启/g' feeds/luci/applications/luci-app-watchcat/luasrc/model/cbi/watchcat/watchcat.lua

sed -i 's/services/nas/g'  `grep services -rl feeds/luci/applications/luci-app-aria2/luasrc`
sed -i 's/Aria2 配置/通用下载/g' feeds/luci/applications/luci-app-aria2/po/zh-cn/aria2.po

sed -i '/msgid "Transmission"/{n;s/Transmission/BtPt下载/;}' feeds/luci/applications/luci-app-transmission/po/zh-cn/transmission.po
sed -i 's/services/nas/g'  `grep services -rl feeds/luci/applications/luci-app-transmission/luasrc`

sed -i '/msgid "UPnP"/{n;s/UPnP/UPnP服务/;}' feeds/luci/applications/luci-app-upnp/po/zh-cn/upnp.po

sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Reboot"/{n;s/重启/立即重启/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i 's/KMS 服务器/KMS 服务/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po

sed -i '/msgid "Pass Wall"/{n;s/PassWall/畅游国际/;}' package/openwrt-packages/luci-app-passwall/luci-app-passwall/po/zh-cn/passwall.po
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-passwall/luci-app-passwall/luasrc`

sed -i 's/京东签到服务/京东签到/g' package/openwrt-packages/luci-app-jd-dailybonus/po/zh-cn/jd-dailybonus.po
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-jd-dailybonus/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-smartdns/luasrc`

sed -i 's/KoolProxyR plus+/广告过滤/g' package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci/controller/koolproxy.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci`

sed -i 's/AdGuard Home/AdGuard/g' package/diy/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/services/vpn/g'  `grep services -rl package/diy/luci-app-adguardhome/luasrc`

sed -i 's/广告屏蔽大师 Plus+/广告屏蔽/g' package/lean/luci-app-adbyby-plus/po/zh-cn/adbyby.po
sed -i 's/services/vpn/g'  `grep services -rl package/lean/luci-app-adbyby-plus/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/OpenClash/luci-app-openclash/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/luasrc`
sed -i 's/ShadowSocksR Plus+ 设置/SSR Plus设置/g' package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/po/zh-cn/ssr-plus.po
echo -e "\nmsgid \"ShadowSocksR Plus+\"" >> package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/po/zh-cn/ssr-plus.po
echo -e "msgstr \"畅游国际\"" >> package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/po/zh-cn/ssr-plus.po

sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-serverchan/luasrc`

##############自定义结束#################
