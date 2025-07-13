# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "steamworks-sdk::steamworks-sdk" for configuration "Debug"
set_property(TARGET steamworks-sdk::steamworks-sdk APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(steamworks-sdk::steamworks-sdk PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
        IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/lib/libsteam_api.dylib"
)

list(APPEND _cmake_import_check_targets steamworks-sdk::steamworks-sdk )
list(APPEND _cmake_import_check_files_for_steamworks-sdk::steamworks-sdk "${_IMPORT_PREFIX}/debug/lib/libsteam_api.dylib")

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
