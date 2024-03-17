vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Kadowns/grapphs
        REF 0.1.5
        SHA512 ff0cee1988f4b7c99fad47cabb06c9d85f274b2fe7ee909dc12b7724e1f7a681c6b9e26642d04d7c0804edca54f099554ab5e441b84ed1a59e1f35fdb18ad5ba
        HEAD_REF master
)

vcpkg_cmake_configure(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS
            -DGRAPPHS_COMPILE_TESTS=OFF
            -DGRAPPHS_COMPILE_GRAPHVIZ=OFF
            -DGRAPPHS_COMPILE_SVG=OFF
            -DGRAPPHS_COMPILE_SAMPLES=OFF
            -DGRAPPHS_VERSION=0.1.5
)
vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(INSTALL "${SOURCE_PATH}/LICENSE.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/grapphs" RENAME copyright)
configure_file("usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
