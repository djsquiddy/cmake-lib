
# default search dirs
SET(_cereal_HEADER_SEARCH_DIRS
    "/usr/include"
    "/usr/local/include"
    $ENV{PhoenixInclude})

# check environment variable
SET(_cereal_ENV_ROOT_DIR "$ENV{CEREAL_ROOT_DIR}")

IF(NOT CEREAL_ROOT_DIR AND _cereal_ENV_ROOT_DIR)
    SET(CEREAL_ROOT_DIR "${_cereal_ENV_ROOT_DIR}")
ENDIF(NOT CEREAL_ROOT_DIR AND _cereal_ENV_ROOT_DIR)

# put user specified location at beginning of search
IF(CEREAL_ROOT_DIR)
    SET(_cereal_HEADER_SEARCH_DIRS "${CEREAL_ROOT_DIR}"
                                "${CEREAL_ROOT_DIR}/include"
                                 ${_cereal_HEADER_SEARCH_DIRS})
ENDIF(CEREAL_ROOT_DIR)

# locate header
FIND_PATH(CEREAL_INCLUDE_DIR 
    "cereal/cereal.hpp"
    PATHS ${_cereal_HEADER_SEARCH_DIRS})

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(CEREAL DEFAULT_MSG
    CEREAL_INCLUDE_DIR)

IF(CEREAL_FOUND)
    SET(CEREAL_INCLUDE_DIRS "${CEREAL_INCLUDE_DIR}")

    MESSAGE(STATUS "CEREAL_INCLUDE_DIR = ${CEREAL_INCLUDE_DIR}")
ENDIF(CEREAL_FOUND)