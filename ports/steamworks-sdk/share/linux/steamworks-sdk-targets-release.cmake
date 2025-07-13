# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "steamworks-sdk::steamworks-sdk" for configuration "Release"
set_property(TARGET steamworks-sdk::steamworks-sdk APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(steamworks-sdk::steamworks-sdk PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
        IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libsteam_api.so"
)

list(APPEND _cmake_import_check_targets steamworks-sdk::steamworks-sdk )
list(APPEND _cmake_import_check_files_for_steamworks-sdk::steamworks-sdk "${_IMPORT_PREFIX}/lib/libsteam_api.so")

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
