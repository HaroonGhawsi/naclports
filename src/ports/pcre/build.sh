#!/bin/bash
# Copyright (c) 2013 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

if [ "${NACL_SHARED}" = "1" ]; then
  EXE_DIR=".libs/"
else
  EXE_DIR=""
fi

EXECUTABLES="${EXE_DIR}pcre_scanner_unittest${NACL_EXEEXT} \
  ${EXE_DIR}pcre_stringpiece_unittest${NACL_EXEEXT} \
  ${EXE_DIR}pcrecpp_unittest${NACL_EXEEXT}"

# There are two additional tests (RunGrepTest and RunTest shell scripts) that
# make check does but it would be hard to run it here. Especially the first one.
TestStep() {
  # test only pnacl and if target and host architectures match
  if [ "${NACL_ARCH}" = "pnacl" ]; then
    for test in ${EXECUTABLES}; do
        RunSelLdrCommand ${test}
    done
    echo "Tests OK"
  elif [ `uname -m` == "${NACL_ARCH_ALT}" ]; then
    for test in ${EXECUTABLES}; do
      ./${test%%${NACL_EXEEXT}}
    done
    echo "Tests OK"
  fi
}
