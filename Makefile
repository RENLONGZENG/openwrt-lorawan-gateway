include $(TOPDIR)/rules.mk
 
PKG_NAME:=lorwan-gateway
PKG_RELEASE:=1

PLATFORM_NAME:=OPENWRT
BOARD_NAME:=MC7628_GAS
SX1302_RESET_PIN:=5
LGW_TARGET_DIR:=./install/
LGW_TARGET_USR:=admin
 
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
 
include $(INCLUDE_DIR)/package.mk

define Package/lorwan-gateway
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=lorwan-gateway
	DEPENDS:=+libpthread +librt
endef

define Package/lorwan-gateway/description
	lorwan-gateway for openwrt
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./sx1302_hal/* $(PKG_BUILD_DIR)/
	$(CP) ./platform/ $(PKG_BUILD_DIR)/
endef

define Build/Configure
	if [ $(PLATFORM_NAME) == OPENWRT ]; then \
		$(LN) $(PKG_BUILD_DIR)/platform/openwrt/package/lorawan-gateway/_install/ $(PKG_BUILD_DIR)/platform/board_install; \
	fi
	sed -i "s:TARGET_DIR=/home/pi/sx1302_hal/bin:TARGET_DIR=$(LGW_TARGET_DIR):g" $(PKG_BUILD_DIR)/target.cfg
	sed -i s/TARGET_USR=pi/TARGET_USR=$(LGW_TARGET_USR)/g $(PKG_BUILD_DIR)/target.cfg
endef

define Build/Compile
	@echo build...
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)"
endef

define Package/lorwan-gateway/install
	@echo install to $(PKG_BUILD_DIR)...
	$(MAKE) install -C $(PKG_BUILD_DIR)
	@echo install_conf to $(PKG_BUILD_DIR)...
	$(MAKE) install_conf -C $(PKG_BUILD_DIR)
	@echo install gateway config to $(1)...
	$(INSTALL_DIR) $(1)/etc/lorawan_gw_config/
	$(INSTALL_DIR) $(1)/etc/lorawan_gw_config/backup/
	@echo install gateway bin to $(1)...
	$(INSTALL_DIR) $(1)/usr/bin/
	@echo install gateway test bin to $(1)...
	@echo install luci web config to $(1)...
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/admin/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/admin_gateway/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/admin_status/
	if [ ! -f $(1)/etc/board.info ]; then \
		touch $(PKG_BUILD_DIR)/install/etc/board.info; \
		echo $(BOARD_NAME) >$(PKG_BUILD_DIR)/install/etc/board.info; \
	fi
	sed -i s/SX1302_RESET_PIN=5/SX1302_RESET_PIN=$(SX1302_RESET_PIN)/g $(PKG_BUILD_DIR)/install/usr/bin/reset_lgw.sh
	$(CP) $(PKG_BUILD_DIR)/install/* $(1)/
endef

$(eval $(call BuildPackage,lorwan-gateway))
