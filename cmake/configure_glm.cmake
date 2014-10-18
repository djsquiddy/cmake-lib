#========================================================== 
find_package(GLM REQUIRED)
include_directories(${GLM_INCLUDE_DIR})
add_definitions(-DGLM_FORCE_RADIANS)
set(GLI_PACKAGE_DIR $ENV{PhoenixInclude})
find_package(GLI REQUIRED)
include_directories(${GLI_INCLUDE_DIR})
#========================================================== 