### 簡介

這是一個用在安卓設備上的網絡代理腳本，通過iptables攔截流量並轉發到指定的代理服務器程序，用於實現魔法上網之類的功能（我只是單純地不喜歡看到狀態欄有小鑰匙圖標）。

### 文件解析

clash文件夾用於存放clash程序和配置文件。

overture文件夾用於存放overture程序和配置文件，這是一個DNS處理程序。

redsocks2文件夾用於存放redsocks2程序和配置文件，這是一個用於接收iptables轉發的流量，並以socks轉發出去的程序。

tiny文件夾用於存放tiny程序和配置文件，這是一個用於修改HTTP請求頭的代理服務器程序。

v2ray文件夾用於存放v2ray程序和配置文件。

start-core.sh是核心程序啟動腳本。

start.sh是完全啟動腳本，包括核心程序和iptables防火墻，以及防火墻功能配置。

state.sh是核心程序和防火墻狀態檢查腳本。

stop.sh是核心程序和防火墻關閉腳本。

### 使用方法

首先您的安卓設備需要有root權限，並且安裝了busybox，可以使用magisk以及magisk上的busybox模塊，另外您可能需要用到Root Explorer之類的文件管理器。

打包下載所有文件，解壓縮，將得到的文件夾命名為APFC，將APFC文件夾存放到安卓設備根目錄的/data路徑下。

此時啟動腳本的完整路徑是/data/APFC/start.sh。

將APFC文件夾以及所有子文件和子文件夾的權限全部設置為777。

以v2ray為例，您需要先下載v2ray程序並存放到v2ray文件夾，這裡因為GitHub不能上傳大於25MB的文件所以不能完整上傳。

然後將v2ray配置文件存放到v2ray文件夾中，注意擴展名。

確保v2ray配置有dokodemo-door類型的inbound，且將start.sh中的目標轉發端口設置為dokodemo-door的監聽端口。

然後在start-core.sh中啟用您需要開啟的核心程序，這裡是v2ray，所以您可以將除了v2ray以外的核心啟動代碼注釋掉，然後執行start.sh即可。

如果您需要使用clash，您仍然需要按照上述步驟配置v2ray，但是建議使用本項目中提供的v2ray配置，也不用額外修改start.sh中的目標轉發端口。

您需要通過[https://acl4ssr.netlify.app](https://acl4ssr.netlify.app)進行訂閱鏈接轉換。

下載clash配置文件並命名為config.yaml，將config.yaml存放到clash文件夾中，最後執行start.sh。

### 注意事項

防火墻默認代理所有應用，如果不想代理某個應用，請在start.sh中繞過所有協議那一項填寫不需要代理的應用的UID，多個UID以空格分開。

您可以通過Shadowsocks或AFWall+查看每個應用的UID。

上述沒有提到的start.sh配置不建議更改。

v2ray具有redsocks2的功能，而DNS處理僅需要正確配置resolv.conf即可，所以也用不到overture。

tiny具有DNS處理和處理來自iptables轉發的數據的功能。

綜上所述，overture和redsocks2目前沒啥用。

clash不具備上述功能（目前我沒找到，或者有但是我還不知道怎麼用），因此我給出的方案是使用v2ray中繼後轉發給clash。

### 致謝

iptables規則 by Joyace

Tiny by 烟火的光芒

clash: [https://github.com/Dreamacro/clash](https://github.com/Dreamacro/clash)

overture: [https://github.com/shawn1m/overture](https://github.com/shawn1m/overture)

redsocks2: [https://github.com/akamensky/redsocks2](https://github.com/akamensky/redsocks2)

v2ray: [https://github.com/v2fly/v2ray-core](https://github.com/v2fly/v2ray-core)
