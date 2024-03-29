# Copyright (c) 2014 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EXECUTABLES="libgit2_clar"

if [ "${NACL_SHARED}" != "1" ]; then
  EXTRA_CMAKE_ARGS="-DBUILD_SHARED_LIBS=OFF"
fi

if [ "${NACL_LIBC}" = "newlib" ]; then
  NACLPORTS_CPPFLAGS="-I${NACLPORTS_INCLUDE}/glibc-compat"
  # newlib headers generate a lot of char-subscript warnings
  # for macros such as tolower()
  NACLPORTS_CPPFLAGS+=" -Wno-char-subscripts"
  if [ "$NACL_ARCH" != "arm" ]; then
    # Our x86 version of gcc generates a lot of strict aliasing
    # warnings.
    NACLPORTS_CPPFLAGS+=" -fno-strict-aliasing"
  fi
fi
