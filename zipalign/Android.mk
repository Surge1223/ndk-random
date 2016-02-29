# 
# Copyright 2008 The Android Open Source Project
#
# Zip alignment tool
#

LOCAL_PATH := $(call my-dir)
NDK_OUT := $(LOCAL_PATH)/
NDK_LIBS_OUT := $(LOCAL_PATH)/
APP_BUILD_SCRIPT := $(LOCAL_PATH)/Application.mk
zopfli_BUILD_SCRIPT := $(LOCAL_PATH)/zopfli/Android.mk
zlib_BUILD_SCRIPT := $(LOCAL_PATH)/zlib/Android.mk		
_zopfli            := zopfli
_zopfli_mk := $(zopfli_BUILD_SCRIPT)
NDK_APPS        := $(__zopfli) $(__zlib)
_zlib            := zlib
_zlib_mk := $(zlib_BUILD_SCRIPT)


$(shell mkdir -p $(LOCAL_PATH)/zlib-lib/)
#$(shell echo "static lib creating within Android.mk file " ) \
$(shell mkdir -p $(LOCAL_PATH)/zopfli-lib/)

#$(shell mkdir -p $(addprefix $(TARGET_ROOT_OUT)/, \
#    sbin dev proc sys system data oem))
	
#$(shell cp -fR $(LOCAL_PATH)/vendor/* $(TARGET_OUT_VENDOR)/)

LIBS_OUT := $(LOCAL_PATH)/libs/
$(LIBS_OUT): $(_zopfli_mk)
		@echo "static lib creating within Android.mk file " 
		@mkdir -p $@
			mkdir -p $@/$(LOCAL_PATH)/libs); \
		)

ifneq ($(LIBS_OUT),$($(LOCAL_PATH)/libs/))
ALL_DEFAULT_INSTALLED_MODULES += $(LIBS_OUT)
endif

zipalign_files := \
	ZipAlign.cpp \
	ZipEntry.cpp \
	ZipFile.cpp \
	logstubs.cpp	

ifneq ($(LIBS_OUT),$($(LOCAL_PATH)/libs/))

zlib_files := \
	zlib/src/adler32.c \
	zlib/src/compress.c \
	zlib/src/crc32.c \
	zlib/src/deflate.c \
	zlib/src/gzclose.c \
	zlib/src/gzlib.c \
	zlib/src/gzread.c \
	zlib/src/gzwrite.c \
	zlib/src/infback.c \
	zlib/src/inflate.c \
	zlib/src/inftrees.c \
	zlib/src/inffast.c \
	zlib/src/trees.c \
	zlib/src/uncompr.c \
	zlib/src/zutil.c

include $(CLEAR_VARS)
zopfli_files := \
	zopfli/src/zopfli/blocksplitter.c \
	zopfli/src/zopfli/cache.c \
	zopfli/src/zopfli/deflate.c \
	zopfli/src/zopfli/gzip_container.c \
	zopfli/src/zopfli/hash.c \
	zopfli/src/zopfli/katajainen.c \
	zopfli/src/zopfli/lz77.c \
	zopfli/src/zopfli/squeeze.c \
	zopfli/src/zopfli/tree.c \
	zopfli/src/zopfli/util.c \
	zopfli/src/zopfli/zlib_container.c \
	zopfli/src/zopfli/zopfli_lib.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include \
	$(LOCAL_PATH)/include/android \
	$(LOCAL_PATH)/zlib \
	$(LOCAL_PATH)/zopfli/src \
	$(LOCAL_PATH)/zopfli/src/zopfli
	
LOCAL_STATIC_LIBRARIES := \
	libutils \
	libcutils \
	liblog \
	libc
	 
LOCAL_LDLIBS    := -landroid -llog $(LOCAL_PATH)/libm.a
LOCAL_MODULE := libzopfli
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -O2
LOCAL_MODULE_PATH := $(LOCAL_PATH)/
LOCAL_LDFLAGS += 

ifdef TARGET_2ND_ARCH
LOCAL_MULTILIB := both
LOCAL_SRC_FILES_64 :=  $(zopfli_files)
LOCAL_SRC_FILES_32 :=  $(zopfli_files)
else
LOCAL_SRC_FILES :=  $(zopfli_files)
endif
include $(BUILD_STATIC_LIBRARY)
include $(CLEAR_VARS)

# measurements show that the ARM version of ZLib is about x1.17 faster
# than the thumb one...
LOCAL_ARM_MODE := arm
LOCAL_MODULE := libz
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(LOCAL_PATH)/
LOCAL_CFLAGS += -O3 -DUSE_MMAP

ifeq ($(TARGET_ARCH),arm)
  LOCAL_SDK_VERSION := 9
endif

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
LOCAL_C_INCLUDES := include \
	$(LOCAL_PATH)/include/android \
	$(LOCAL_PATH)/zlib \
	$(LOCAL_PATH)/zopfli/src \
	$(LOCAL_PATH)/zopfli/src/zopfli
	
ifdef TARGET_2ND_ARCH
LOCAL_MULTILIB := both
LOCAL_SRC_FILES_64 := $(zlib_files)
LOCAL_SRC_FILES_32 := $(zlib_files)
else
LOCAL_SRC_FILES := $(zlib_files)
endif
include $(BUILD_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)

LOCAL_MODULE := zipalign

$(shell cp $(LOCAL_PATH)/obj/local/armeabi/libz.a $(LOCAL_PATH)/zlib-lib/)
$(shell cp $(LOCAL_PATH)/obj/local/armeabi/libzopfli.a $(LOCAL_PATH)/zopfli-lib/)

LOCAL_LDFLAGS += $(LOCAL_PATH)/libandroidfw.a \
	$(LOCAL_PATH)/libandroidfw.a \
	$(LOCAL_PATH)/libutils.a \
	$(LOCAL_PATH)/libcutils.a \
	$(LOCAL_PATH)/liblog.a  \
	$(LOCAL_PATH)/libm.a  \
	$(LOCAL_PATH)/zlib-lib/libz.a  \
	$(LOCAL_PATH)/zopfli-lib/libzopfli.a 
	
LOCAL_ADDITIONAL_DEPENDENCIES :=  $(zopfli_BUILD_SCRIPT) $(zlib_BUILD_SCRIPT) $(NDK_APPS)
LOCAL_SRC_FILES :=  $(zipalign_files)

LOCAL_C_INCLUDES := include \
	$(LOCAL_PATH)/include/android \
	$(LOCAL_PATH)/zlib \
	$(LOCAL_PATH)/zopfli/src \
	$(LOCAL_PATH)/zopfli/src/zopfli
LOCAL_CFLAGS += -fPIC
LOCAL_STATIC_LIBRARIES := libc libzopfli libz
LOCAL_FORCE_STATIC_EXECUTABLE := true
include $(BUILD_EXECUTABLE)
