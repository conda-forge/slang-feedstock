#!/bin/bash

set -ex

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* autoconf

# configure tool is mixing CXXFLAGS with CPPFLAGS
# export CFLAGS="${CFLAGS} ${CPPFLAGS}"

./configure \
  --prefix=$PREFIX  \
  --with-readline=gnu \
  --with-pcre \
  --with-onig \
  --with-png \
  --with-z \
  --with-iconv=$PREFIX || { cat config.log; exit 1; }

# Parallel make fails
make

if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  make check
fi

make install
