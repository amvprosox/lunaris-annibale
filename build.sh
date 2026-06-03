#!/bin/bash
set -e
REPO=$(pwd)
mkdir -p ~/lunaris && cd ~/lunaris
repo init -u https://github.com/Lunaris-AOSP/android -b 16.2 --git-lfs --no-clone-bundle
mkdir -p .repo/local_manifests
cp $REPO/local_manifests/*.xml .repo/local_manifests/
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
cd device/xiaomi/annibale && git am < $REPO/patches/01-device-annibale.patch; cd ~/lunaris
cd packages/apps/Aperture && git am < $REPO/patches/02-aperture-ultrahdr.patch; cd ~/lunaris
cd hardware/lineage/compat && git am < $REPO/patches/03-compat-libtinyxml2.patch; cd ~/lunaris
cd vendor/extras && git am < $REPO/patches/04-vendor-extras-overlays.patch; cd ~/lunaris
source build/envsetup.sh
lunch lineage_annibale-bp4a-userdebug
mka bacon
