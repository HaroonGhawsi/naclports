/*
 * Copyright (c) 2013 The Native Client Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <libtar.h>
#include <stdio.h>
#include <string.h>

#include "nacl_io/nacl_io.h"
#include "ppapi_simple/ps_main.h"

extern int nacl_nano_main(int argc, char *argv[]);

int nano_pepper_main(int argc, char* argv[]) {
  umount("/");
  mount("foo", "/", "memfs", 0, NULL);
  mount("./", "/tars", "httpfs", 0, NULL);

  mkdir("/home", 0777);

  /* Setup home directory to a known location. */
  setenv("HOME", "/home", 1);
  /* Blank out USER and LOGNAME. */
  setenv("USER", "", 1);
  setenv("LOGNAME", "", 1);

  TAR* tar;
  int ret = tar_open(&tar, "/tars/nano.tar", NULL, O_RDONLY, 0, 0);
  assert(ret == 0);

  ret = tar_extract_all(tar, "/");
  assert(ret == 0);

  ret = tar_close(tar);
  assert(ret == 0);

  const char *myargv[] = {"nano"};
  return nacl_nano_main(1, (char**)myargv);
}

PPAPI_SIMPLE_REGISTER_MAIN(nano_pepper_main)
