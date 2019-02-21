#!/bin/bash

# @file
# @brief Configure clonned project
#
# $Id: $

echo Initializing project submodules

cd $(dirname $0)
git submodule init
git submodule sync
git submodule update
cd -
