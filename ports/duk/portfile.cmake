vcpkg_from_git(
        OUT_SOURCE_PATH SOURCE_PATH
        URL https://github.com/duk-studios/duk
        REF 9a9eb94afc60b0aff013fc39e75671a5bf57b4e9
        HEAD_REF master
)

vcpkg_cmake_configure(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS
        -DDUK_BUILD_SAMPLES=OFF
        -DDUK_BUILD_TESTS=OFF
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup()
vcpkg_copy_tools(TOOL_NAMES duk AUTO_CLEAN)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")

