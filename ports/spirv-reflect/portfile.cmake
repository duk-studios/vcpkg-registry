vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO duk-studios/SPIRV-Reflect
        REF "vulkan-sdk-${VERSION}"
        SHA512 fdc59a4a41e0124eb6128e739e9ba494cb74b5f9940055aa2d6d7cf6436074b2023dc14fe5bbd780c382df564e6f4cac37cab74ce7199c9ee0f2aec05b944b02
        HEAD_REF main
)

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS -DSPIRV_REFLECT_STATIC_LIB=ON
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

vcpkg_copy_tools(TOOL_NAMES spirv-reflect-pp spirv-reflect AUTO_CLEAN)
