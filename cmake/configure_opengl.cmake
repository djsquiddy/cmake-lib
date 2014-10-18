#========================================================== 
# FIND OPENGL 
#========================================================== 
find_package(OpenGL REQUIRED) 
include_directories(${OpenGL_INCLUDE_DIRS}) 
message("OpenGL_INCLUDE_DIRS: ${OpenGL_INCLUDE_DIRS}")
link_directories(${OpenGL_LIBRARY_DIRS}) 
message("OPENGL_LIBRARIES: ${OPENGL_LIBRARIES}")
add_definitions(${OpenGL_DEFINITIONS}) 
message("OpenGL_DEFINITIONS: ${OpenGL_DEFINITIONS}")
if(NOT OPENGL_FOUND) 
    message(ERROR " OPENGL not found!") 
else(NOT OPENGL_FOUND)
    message("OPENGL found!") 
endif(NOT OPENGL_FOUND) 

if(APPLE)
  find_library(COCOA_LIBRARY Cocoa)
  find_library(OpenGL_LIBRARY OpenGL)
  find_library(IOKit_LIBRARY IOKit)
  MARK_AS_ADVANCED(COCOA_LIBRARY OpenGL_LIBRARY)
  set(EXTRA_LIBS ${EXTRA_LIBS} ${COCOA_LIBRARY} ${IOKit_LIBRARY} ${OpenGL_LIBRARY})
endif(APPLE)