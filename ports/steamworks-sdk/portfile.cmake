# taken https://github.com/Aleph-One-Marathon/vcpkg-registry/tree/main
set(VCPKG_LIBRARY_LINKAGE dynamic)

vcpkg_extract_source_archive(SOURCE_PATH
        ARCHIVE "${CMAKE_CURRENT_LIST_DIR}/steamworks_sdk_162.zip"
)

if(VCPKG_TARGET_IS_WINDOWS)

    if(VCPKG_TARGET_ARCHITECTURE STREQUAL x64)

        set(SDK_DESTINATION_PATH "${SOURCE_PATH}/redistributable_bin/win64/steam_api64")
        set(CMAKE_TARGETS_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/share/win64")

    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL x86)

        set(SDK_DESTINATION_PATH "${SOURCE_PATH}/redistributable_bin/steam_api")
        set(CMAKE_TARGETS_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/share/win32")
    endif()

    set(STEAMCMD_PATH "${SOURCE_PATH}/tools/ContentBuilder/builder")

    file(INSTALL "${SDK_DESTINATION_PATH}.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
    file(INSTALL "${SDK_DESTINATION_PATH}.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
    file(INSTALL "${SDK_DESTINATION_PATH}.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/bin")
    file(INSTALL "${SDK_DESTINATION_PATH}.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin")

elseif(VCPKG_TARGET_IS_OSX)

    set(VCPKG_FIXUP_MACHO_RPATH FALSE)
    set(STEAMCMD_PATH "${SOURCE_PATH}/tools/ContentBuilder/builder_osx")
    set(CMAKE_TARGETS_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/share/osx")

    file(INSTALL "${SOURCE_PATH}/redistributable_bin/osx/libsteam_api.dylib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
    file(INSTALL "${SOURCE_PATH}/redistributable_bin/osx/libsteam_api.dylib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")

elseif(VCPKG_TARGET_IS_LINUX)

    set(VCPKG_FIXUP_ELF_RPATH FALSE)
    set(STEAMCMD_PATH "${SOURCE_PATH}/tools/ContentBuilder/builder_linux")
    set(CMAKE_TARGETS_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/share/linux")

    file(INSTALL "${SOURCE_PATH}/redistributable_bin/linux64/libsteam_api.so" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
    file(INSTALL "${SOURCE_PATH}/redistributable_bin/linux64/libsteam_api.so" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")

endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/Readme.txt")

file(COPY "${STEAMCMD_PATH}/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}")
file(COPY "${SOURCE_PATH}/public/steam" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(COPY "${CMAKE_TARGETS_FILE_PATH}/" DESTINATION "${CURRENT_PACKAGES_DIR}/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")