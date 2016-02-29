
LOCAL_PATH := $(call-my-dir)
# measurements show that the ARM version of ZLib is about x1.17 faster
# than the thumb one...
LOCAL_ARM_MODE := arm

zlib_files := \
	$(LOCAL_PATH)/zlib/src/adler32.c \
	$(LOCAL_PATH)/zlib/src/compress.c \
	$(LOCAL_PATH)/zlib/src/crc32.c \
	$(LOCAL_PATH)/zlib/src/deflate.c \
	$(LOCAL_PATH)/zlib/src/gzclose.c \
	$(LOCAL_PATH)/zlib/src/gzlib.c \
	$(LOCAL_PATH)/zlib/src/gzread.c \
	$(LOCAL_PATH)/zlib/src/gzwrite.c \
	$(LOCAL_PATH)/zlib/src/infback.c \
	$(LOCAL_PATH)/zlib/src/inflate.c \
	$(LOCAL_PATH)/zlib/src/inftrees.c \
	$(LOCAL_PATH)/zlib/src/inffast.c \
	$(LOCAL_PATH)/zlib/src/trees.c \
	$(LOCAL_PATH)/zlib/src/uncompr.c \
	$(LOCAL_PATH)/zlib/src/zutil.c

# than the thumb one...
LOCAL_MODULE := libz
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(LOCAL_PATH)/
LOCAL_CFLAGS += -O3 -DUSE_MMAP


ifeq ($(TARGET_ARCH),arm)
  LOCAL_SDK_VERSION := 9
endif
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
ifdef TARGET_2ND_ARCH
LOCAL_MULTILIB := both
LOCAL_SRC_FILES_64 := $(zlib_files)
LOCAL_SRC_FILES_32 := $(zlib_files)
else
LOCAL_SRC_FILES := $(zlib_files)
endif
include $(BUILD_STATIC_LIBRARY)
