
# Copyright (C) 2012-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=fcgiwrap
PKG_VERSION:=1.1.0-ab
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=https://github.com/abiuan/fcgiwrap.git
PKG_SOURCE_DATE:=2021-07-28
PKG_SOURCE_VERSION:=97a1d7ec4b168e967463abc01a2ea8ed32df6dea
#PKG_MIRROR_HASH:=
PKG_MAINTAINER:=abiuan
PKG_LICENSE:=MIT

PKG_BUILD_DIR:=$(BUILD_DIR)/fcgiwrap-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

CONFIGURE_ARGS += \
	--with-systemd

include $(INCLUDE_DIR)/package.mk

define Package/fcgiwrap
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=fcgiwrap for web server
  URL:=https://github.com/abiuan/fcgiwrap.git
  DEPENDS:=+spawn-fcgi +fcgi
  MENU:=0
endef

define Package/fcgiwrap/description
  Simple FastCGI wrapper for CGI scripts
endef

TARGET_CFLAGS += 
TARGET_LDFLAGS += 

define Package/fcgiwrap/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/fcgiwrap $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/fcgiwrap.init $(1)/etc/init.d/fcgiwrap
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

$(eval $(call BuildPackage,fcgiwrap))

