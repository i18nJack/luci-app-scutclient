include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-scutclient
PKG_VERSION:=2.0.1
PKG_RELEASE:=0
PKG_LICENSE:=Apache-2.0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-scutclient
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for scutclient
	URL:=
	DEPENDS:=+scutclient
	PKGARCH:=all
endef

define Package/luci-app-scutclient/description
	LuCI Support for scutclient.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-scutclient/install
	$(INSTALL_DIR) $(1)/uci-defaults
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/scutclient
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/scutclient
	$(INSTALL_DATA) ./files/luci/model/cbi/scutclient/scutclient.lua $(1)/usr/lib/lua/luci/model/cbi/scutclient/scutclient.lua
	$(INSTALL_DATA) ./files/luci/controller/scutclient.lua $(1)/usr/lib/lua/luci/controller/scutclient.lua
	$(INSTALL_DATA) ./files/luci/view/scutclient/about.htm $(1)/usr/lib/lua/luci/view/scutclient/about.htm
	$(INSTALL_DATA) ./files/luci/view/scutclient/logs.htm $(1)/usr/lib/lua/luci/view/scutclient/logs.htm
	$(INSTALL_DATA) ./files/luci/view/scutclient/status.htm $(1)/usr/lib/lua/luci/view/scutclient/status.htm
endef

$(eval $(call BuildPackage,luci-app-scutclient))
