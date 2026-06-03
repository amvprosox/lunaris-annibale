
# Lunaris AOSP - POCO F8 Pro (annibale)

Unofficial Lunaris AOSP (Android 16 QPR2) build for Xiaomi POCO F8 Pro (annibale).

Maintainer: amvprosox

## Build instructions

### 1. Init Lunaris source
repo init -u https://github.com/Lunaris-AOSP/android -b 16.2 --git-lfs --no-clone-bundle
### 2. Add local manifests
Copy both XMLs from `local_manifests/` into `.repo/local_manifests/`:
mkdir -p .repo/local_manifests
cp local_manifests/*.xml .repo/local_manifests/
### 3. Sync
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
cd device/xiaomi/annibale && git am < /path/patches/01-device-annibale.patch && cd -
cd packages/apps/Aperture && git am < /path/patches/02-aperture-ultrahdr.patch && cd -
cd hardware/lineage/compat && git am < /path/patches/03-compat-libtinyxml2.patch && cd -
cd vendor/extras && git am < /path/patches/04-vendor-extras-overlays.patch && cd -
### 5. Build (use bp4a release for QPR2)

source build/envsetup.sh
lunch lineage_annibale-bp4a-userdebug
mka bacon
Output: `out/target/product/annibale/Lunaris-AOSP-annibale-*.zip`

## Notes
- Vendor blobs sync from (ramshell688) via the manifest.
- Singularity is re-pathed into Settings (see singularity.xml) - required for customization to work.
- UltraHDR disabled in Aperture so the camera captures correctly.
- Flash via OrangeFox (Format Data, then sideload). LineageOS recovery enforces SPL downgrade.
