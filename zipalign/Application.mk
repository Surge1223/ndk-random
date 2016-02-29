LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
include zlib/Android.mk
include $(CLEAR_VARS)
include zopfli/Android.mk
APP_ABI := armeabi armeabi-v7a
APP_PLATFORM := android-9
NDK_TOOLCHAIN := arm-linux-androideabi-4.9
APP_STL := gnustl_static
APP_CPPFLAGS += -std=c++11
include $(CLEAR_VARS)
include $(LOCAL_PATH)/Android.mk 


