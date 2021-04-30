NETSERVER_SITE = $(TOPDIR)/../app/netserver
NETSERVER_SITE_METHOD = local

NETSERVER_DEPENDENCIES = libgdbus librkdb

ifeq ($(BR2_PACKAGE_RK_OEM), y)
NETSERVER_INSTALL_TARGET_OPTS = DESTDIR=$(BR2_PACKAGE_RK_OEM_INSTALL_TARGET_DIR) install/fast
NETSERVER_DEPENDENCIES += rk_oem
endif

ifeq ($(BR2_PACKAGE_NETSERVER_SANITIZER_DYNAMIC), y)
NETSERVER_CONF_OPTS += -DSANITIZER_DYNAMIC=ON
else

ifeq ($(BR2_PACKAGE_NETSERVER_SANITIZER_STATIC), y)
NETSERVER_CONF_OPTS += -DSANITIZER_STATIC=ON
endif
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_MINILOGGER), y)
    NETSERVER_CONF_OPTS += -DENABLE_MINILOGGER=ON
    NETSERVER_DEPENDENCIES += minilogger
else
    NETSERVER_CONF_OPTS += -DENABLE_MINILOGGER=OFF
endif

$(eval $(cmake-package))
