#!/bin/bash

set -ex

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

# configure tool is mixing CXXFLAGS with CPPFLAGS
export CFLAGS="${CFLAGS} ${CPPFLAGS}"

./configure \
  --prefix=$PREFIX  \
  --with-readline=gnu \
  --with-pcre \
  --with-onig \
  --with-png \
  --with-z \
  --with-iconv=$PREFIX

make -j${CPU_COUNT}

if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  make check
fi

make install
