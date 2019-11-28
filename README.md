## 安装到路由器
到[最新发布页](https://github.com/ploxolg/luci-app-scutclient/releases/latest)下载 `ipx` 文件用 WinSCP 拖到路由器 `tmp` 目录下，输入如下命令安装：
```
opkg install luci-app-scutclient_2.0-2_all.ipk
```
注：安装前请先安装 scutclient.
### 效果预览
![](/img/1.png)
![](/img/2.png)
![](/img/3.png)


## LuCI 应用编译
参考 [Quick Image Building Guide](https://openwrt.org/docs/guide-developer/quickstart-build-images) 和 [How to Build a Single Package](https://openwrt.org/docs/guide-developer/single.package)

下面使用 Ubuntu 18.04 为例.
### OpenWRT 源码
```
sudo apt install subversion g++ zlib1g-dev build-essential git python python3
sudo apt install libncurses5-dev gawk gettext unzip file libssl-dev wget
sudo apt install libelf-dev ecj fastjar java-propose-classpath
sudo apt install build-essential libncursesw5-dev python unzip

git clone https://github.com/openwrt/openwrt.git
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
```
### luci-app-scutclient
```
git clone git@github.com:ploxolg/luci-app-scutclient.git
cp -r luci-app-scutclient feeds/luci/applications
ls feeds/luci/applications/luci-app-scutclient
./scripts/feeds install -a -p luci
```

### 编译
```
make tools/install
make toolchain/install

make menuconfig
make V=99
```

注：luci-app 需要完整编译才能成功，如果只要 ipk 文件，可以到 `bin` 对应的子目录下观察文件生成了没，生成后就不用再等了。

## 说明
版权属于原作者，此处仅供自用，勿做他用。
