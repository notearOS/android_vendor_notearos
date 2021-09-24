# Kernel
include vendor/notearos/config/BoardConfigKernel.mk

# QCOM flags
ifeq ($(call is-vendor-board-platform,QCOM),true)
include device/qcom/common/BoardConfigQcom.mk
endif

# SEPolicy
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    vendor/notearos/sepolicy/private

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    vendor/notearos/sepolicy/public

BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/notearos/sepolicy/vendor

# Soong
include vendor/notearos/config/BoardConfigSoong.mk
