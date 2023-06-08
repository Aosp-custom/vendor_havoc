# Audio
$(call inherit-product, vendor/lineage/config/audio.mk)

# Fonts
$(call inherit-product, vendor/lineage/config/fonts.mk)

# Themed icons
$(call inherit-product, packages/overlays/ThemeIcons/config.mk)

# Pixel Framework
$(call inherit-product, vendor/pixel-framework/config.mk)

# Additional props
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true \
    persist.sys.disable_rescue=true \

# Volume Styles
PRODUCT_PACKAGES += \
    VolumeStyle1Overlay \
    VolumeStyle2Overlay \
    VolumeStyle3Overlay \
    VolumeStyle4Overlay \
    VolumeStyle5Overlay

# Setupwizard
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.day_night_mode_enabled=true \
    setupwizard.feature.lifecycle_refactoring=true \
    setupwizard.feature.notification_refactoring=true \
    setupwizard.feature.portal_notification=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.theme=glif_v3_light

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Blurs
ifeq ($(TARGET_ENABLE_BLUR), true)
    PRODUCT_SYSTEM_EXT_PROPERTIES += \
        ro.sf.blurs_are_expensive=1 \
        ro.surface_flinger.supports_background_blur=1
else
    PRODUCT_PRODUCT_PROPERTIES += \
        ro.launcher.blur.appLaunch=0
endif

# Disable async MTE on system_server
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    arm64.memtag.process.system_server=off

# Enable dex2oat64 to do dexopt
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    dalvik.vm.dex2oat64.enabled=true

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt

# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.show_opt_in=false

# OPA configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# Google legal
PRODUCT_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Google Play services configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# Use gestures by default
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

# Repainter integration
PRODUCT_PACKAGES += \
    RepainterServicePriv

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= $(TARGET_SUPPORTS_64_BIT_APPS)
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
    PRODUCT_PACKAGES += \
        ParanoidSense
    PRODUCT_SYSTEM_EXT_PROPERTIES += \
        ro.face.sense_service.enabled=true
    PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
else
    PRODUCT_PACKAGES += \
        SettingsGoogleFutureFaceEnroll
endif

# Pixel customization
TARGET_SUPPORTS_GOOGLE_RECORDER ?= false
TARGET_INCLUDE_STOCK_ARCORE ?= false
TARGET_INCLUDE_LIVE_WALLPAPERS ?= false
TARGET_SUPPORTS_QUICK_TAP ?= true
TARGET_SUPPORTS_CALL_RECORDING ?= false

# GApps
$(call inherit-product-if-exists, vendor/gms/products/gms.mk)
$(call inherit-product-if-exists, vendor/googleapps/googleapps.mk)
