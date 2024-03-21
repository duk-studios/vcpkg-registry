vcpkg_from_git(
        OUT_SOURCE_PATH SOURCE_PATH
        URL https://github.com/duk-studios/duk
        REF 6009317f2725e6deba19fe16b9fd0756dba0940e
        HEAD_REF develop
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

