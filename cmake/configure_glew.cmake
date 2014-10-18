#========================================================== 
# FIND GLEW 
#========================================================== 
find_package(GLEW REQUIRED) 
include_directories(${GLEW_INCLUDE_DIRS}) 
message("GLEW_INCLUDE_DIRS: ${GLEW_INCLUDE_DIRS}")
link_directories(${GLEW_LIBRARY_DIRS}) 
message("GLEW_LIBRARY_DIRS: ${GLEW_LIBRARY}")
add_definitions(${GLEW_DEFINITIONS}) 
message("GLEW_DEFINITIONS: ${GLEW_DEFINITIONS}")
if(NOT GLEW_FOUND) 
    message(ERROR " GLEW not found!") 
elseif( GLEW_FOUND)
    message("GLEW found!") 
endif(NOT GLEW_FOUND)