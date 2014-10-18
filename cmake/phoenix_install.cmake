# build a CPack driven installer package
include (InstallRequiredSystemLibraries)

set (CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set (CPACK_PACKAGE_VERSION_MAJOR "${PHOENIX_VERSION_MAJOR}")
set (CPACK_PACKAGE_VERSION_MINOR "${PHOENIX_VERSION_MINOR}")

include (CPack)
