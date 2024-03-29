# Copyright (c) 2012 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EXECUTABLES="ffmpeg ffmpeg_g ffprobe ffprobe_g"

ConfigureStep() {
  SetupCrossEnvironment

  local extra_args=""
  if [ "${NACL_ARCH}" = pnacl ]; then
    extra_args="--cc=pnacl-clang --arch=pnacl"
  elif [ "${NACL_ARCH}" = arm ]; then
    extra_args="--arch=arm"
  else
    extra_args="--arch=x86"
  fi

  LogExecute ${SRC_DIR}/configure \
    --cross-prefix=${NACL_CROSS_PREFIX}- \
    --target-os=linux \
    --enable-gpl \
    --enable-static \
    --enable-cross-compile \
    --disable-inline-asm \
    --disable-ssse3 \
    --disable-mmx \
    --disable-amd3dnow \
    --disable-amd3dnowext \
    --disable-indevs \
    --disable-protocols \
    --disable-network \
    --enable-protocol=file \
    --enable-libmp3lame \
    --enable-libvorbis \
    --enable-libtheora \
    --disable-ffplay \
    --disable-ffserver \
    --disable-demuxer=rtsp \
    --disable-demuxer=image2 \
    --prefix=${PREFIX} \
    ${extra_args}
}
