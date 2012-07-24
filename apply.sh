#!/bin/bash

unset SUCCESS
on_exit() {
  if [ -z "$SUCCESS" ]; then
    echo "ERROR: $0 failed.  Please fix the above error."
    exit 1
  else
    echo "SUCCESS: $0 has completed."
    exit 0
  fi
}
trap on_exit EXIT

http_patch() {
  PATCHNAME=$(basename $1)
  curl -L -o $PATCHNAME -O -L $1
  cat $PATCHNAME |patch -p1
  rm $PATCHNAME
}

wget_patch() {
  PATCHNAME=$(basename $1)
  wget $1
  cat $PATCHNAME |patch -p1
  rm $PATCHNAME
}

# Change directory verbose
cdv() {
  echo
  echo "*****************************"
  echo "Current Directory: $1"
  echo "*****************************"
  cd $BASEDIR/$1
}

# Change back to base directory
cdb() {
  cd $BASEDIR
}

# Sanity check
if [ -d ../.repo ]; then
  cd ..
fi
if [ ! -d .repo ]; then
  echo "ERROR: Must run this script from the base of the repo."
  SUCCESS=true
  exit 255
fi

# Save Base Directory
BASEDIR=$(pwd)

# Abandon auto topic branch
repo abandon auto
set -e

################ Apply Patches Below ####################

repo start auto external/skia
cdv external/skia
echo "Change I0fae80b1: Neon optimized implementation of S16_opaque_D32_nofilter_DX"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_external_skia refs/changes/72/19672/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto packages/apps/Camera
cdv packages/apps/Camera
echo "Change I92cd6aa1: camera: Fix ZSL and resolution change lockups"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Camera refs/changes/69/19669/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/media
cdv hardware/qcom/media
echo "Change I66033d37: libI420colorconvert: Add new library for MovieStudio color conversions"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_media refs/changes/61/19661/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto bionic
cdv bionic
echo "Change I9234d37e: Bionic/libm: fast neon pow() for small x,y"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_bionic refs/changes/59/19659/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/base
cdv frameworks/base
echo "Change Icb4b9b71: frameworks/base: Fix screen stretch issue for NuPlayer"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/58/19658/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/base
cdv frameworks/base
echo "Change Ib8dfa315: Adjust kernel data stack TCP parameters to optimize performance"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/57/19657/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/media
cdv hardware/qcom/media
echo "Change I5ba11d00: hardware/qcom/media: Use OMX_IVCommon.h header file"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_media refs/changes/17/19417/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "Change I323c10b9: display: Enable triple framebuffers"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/72/19272/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "Change I28d87179: liboverlay: Refactor, bug-fixes, upgrade."
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/73/19273/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "Change I20e9aa8f: hwc: Add VideoOverlay class"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/74/19274/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "Change I9d9f3dff: overlay: Allocate from MM heap as a fallback"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/75/19275/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "Change Ie8be6f79: framebuffer: Fix locking"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/12/19412/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/av
cdv frameworks/av
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_av refs/changes/11/19411/5 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/native
cdv frameworks/native
echo "Change Iff2926e5: native: add support for color-converter"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_native refs/changes/79/19279/3 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/native
cdv frameworks/native
echo "Change I90dd38de: libs/ui: Add support for triple framebuffers"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_native refs/changes/78/19278/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/native
cdv frameworks/native
echo "Change I2b1fac62: native: Add Tile format to OMX_IVCommon"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_native refs/changes/77/19277/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware
cdv hardware/libhardware
echo "Change Iec29018a: hardware: Add field for number of framebuffers supported"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_libhardware refs/changes/76/19276/3 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware
cdv hardware/libhardware
echo "Change I0558cafa: hardware/libhardware: Add APIs to support LPA session"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_libhardware refs/changes/21/19121/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/av
cdv frameworks/av
echo "Change I7e7f4404: audio: Temporary workaround for missing QCOM LPA"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_av refs/changes/20/19120/2 && git cherry-pick FETCH_HEAD
cdb

##### SUCCESS ####
SUCCESS=true
exit 0
