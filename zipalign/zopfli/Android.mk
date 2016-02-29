LOCAL_PATH := $(call-my-dir)

zopfli_files := \
	src/zopfli/blocksplitter.c src/zopfli/cache.c\
    src/zopfli/deflate.c src/zopfli/gzip_container.c\
    src/zopfli/hash.c src/zopfli/katajainen.c\
    src/zopfli/lz77.c src/zopfli/squeeze.c\
    src/zopfli/tree.c src/zopfli/util.c\
    src/zopfli/zlib_container.c src/zopfli/zopfli_lib.c
    
LOCAL_STATIC_LIBRARIES := \
	libutils \
	libcutils \
	liblog \
	libc 
	
LOCAL_LDLIBS    := -landroid -llog
LOCAL_MODULE := libzopfli
LOCAL_MODULE_TAGE := optional
LOCAL_CFLAGS += -O2
ifdef TARGET_2ND_ARCH
LOCAL_MULTILIB := both
LOCAL_SRC_FILES_64 := $(zopfli_files)
LOCAL_SRC_FILES_32 := $(zopfli_files)
else
LOCAL_SRC_FILES := $(zopfli_files)
endif
include $(BUILD_STATIC_LIBRARY)
