vcpkg_from_git(
        OUT_SOURCE_PATH SOURCE_PATH
        URL https://github.com/duk-studios/duk
        REF ${VERSION}
        HEAD_REF master
)

vcpkg_cmake_configure(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS
        -DDUK_BUILD_SAMPLE=OFF
        -DDUK_FORMAT_FILES=OFF
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup()
vcpkg_copy_tools(TOOL_NAMES duk AUTO_CLEAN)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")

