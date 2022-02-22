# game/app specific values
export APP_VERSION="3.07"
export ICONSDIR="."
export ICONSFILENAME="Maelstrom"
export PRODUCT_NAME="Maelstrom"
export EXECUTABLE_NAME="Maelstrom"
export PKGINFO="APPLMLST"
export COPYRIGHT_TEXT="Maelstrom Copyright © 1993 Ambrosia Software. All rights reserved."

#constants
source ../MSPScripts/constants.sh

rm -rf ${BUILT_PRODUCTS_DIR}

rm -rf ${X86_64_BUILD_FOLDER}
mkdir ${X86_64_BUILD_FOLDER}
rm -rf ${ARM64_BUILD_FOLDER}
mkdir ${ARM64_BUILD_FOLDER}

make clean
(ARCH=x86_64 INCLUDES="-I/usr/local/include/SDL2" LIBS="-L/usr/local/lib -lSDL2 -lSDL2_net" make -j$NCPU)
mkdir -p ${X86_64_BUILD_FOLDER}/"${EXECUTABLE_FOLDER_PATH}"
cp "${EXECUTABLE_NAME}" ${X86_64_BUILD_FOLDER}/"${EXECUTABLE_FOLDER_PATH}"
mkdir -p "${X86_64_BUILD_FOLDER}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" || exit 1;
mkdir -p "${X86_64_BUILD_FOLDER}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/Images" || exit 1;
cp -a Images/*.bmp ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}/Images"
cp -a Images/*.cicn ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}/Images"
cp "icon.bmp" ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
cp "Maelstrom_Fonts" ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
cp "Maelstrom_Sounds" ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
cp "Maelstrom_Sprites" ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

make clean
(ARCH=arm64 INCLUDES="-I/opt/homebrew/include/SDL2" LIBS="-L/opt/homebrew/lib -lSDL2 -lSDL2_net" make -j$NCPU)
mkdir -p ${ARM64_BUILD_FOLDER}/"${EXECUTABLE_FOLDER_PATH}"
cp "${EXECUTABLE_NAME}" ${ARM64_BUILD_FOLDER}/"${EXECUTABLE_FOLDER_PATH}"
mkdir -p "${ARM64_BUILD_FOLDER}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" || exit 1;
mkdir -p "${ARM64_BUILD_FOLDER}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/Images" || exit 1;
cp -a Images/*.bmp ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}/Images"
cp -a Images/*.cicn ${X86_64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}/Images"
cp "icon.bmp" ${ARM64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
cp "Maelstrom_Fonts" ${ARM64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
cp "Maelstrom_Sounds" ${ARM64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
cp "Maelstrom_Sprites" ${ARM64_BUILD_FOLDER}/"${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

# create the app bundle
"../MSPScripts/build_app_bundle.sh"

export ENTITLEMENTS_FILE="Maelstrom.entitlements"
"../MSPScripts/sign_and_notarize.sh" "$1" entitlements