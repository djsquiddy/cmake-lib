#========================================================== 
find_package(GLFW3 REQUIRED libglfw)
include_directories(${GLFW3_INCLUDE_PATH})
message("GLFW3_INCLUDE_PATH: ${GLFW3_INCLUDE_PATH}")
link_directories(${GLFW3_LIBRARY})
message("GLFW3_LIBRARY: ${GLFW3_LIBRARY}")

if(NOT GLFW3_FOUND) 
    message(ERROR " GLFW3_FOUND not found!") 
elseif(GLFW3_FOUND)
  if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "APPLE")
    add_definitions(-DGLFW_INCLUDE_GLCOREARB)
  endif()
  message("GLFW3_FOUND found!") 
endif(NOT GLFW3_FOUND)

# include(phoenix_utils)
# include(ExternalProject)
# set(GLFW_PROJECT_NAME "GLFW")
# set(GLFW_CONFIG_PROJECT_NAME "GLFW3")
# set(GLFW_VERSION "master")
# set(GLFW_REPOSITORY "https://github.com/glfw/glfw.git")

# if(NOT PHOENIX_PROJECT_DEPENDENCIES_NAMES)
#   set(PHOENIX_PROJECT_DEPENDENCIES_NAMES)
# endif()

# list(APPEND PHOENIX_PROJECT_DEPENDENCIES_NAMES ${GLFW_PROJECT_NAME})

# set(glfw_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/deps")
# set(glfw_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/deps")
# set(glfw_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>)# -DBUILD_SHARED_LIBS=ON)

# message("glfw_PREFIX='${PHOENIX_DEPENDENCIES_INSTALL_DIR}'")
# message("glfw_INSTALL_DIR='${glfw_INSTALL_DIR}'")
# message("glfw_CMAKE_ARGS='${glfw_CMAKE_ARGS}'")

# ExternalProject_Add(
#        project_${GLFW_PROJECT_NAME}
#        PREFIX ${glfw_PREFIX}
#        GIT_REPOSITORY ${GLFW_REPOSITORY}
#        GIT_TAG ${GLFW_VERSION}
#        TIMEOUT 30
#        INSTALL_DIR ${glfw_INSTALL_DIR}
#        CMAKE_ARGS ${glfw_CMAKE_ARGS}
#      # Disable install step
#      # INSTALL_COMMAND ""
#      # UPDATE_COMMAND ""
#        #DOWNLOAD_DIR "${PROJECT_SOURCE_DIR}/deps/temp/"
#        #SOURCE_DIR "${PROJECT_SOURCE_DIR}/deps/glfw/" 
#      # Wrap download, configure and build steps in a script to log output
#      BUILD_IN_SOURCE ON
#      LOG_DOWNLOAD ON
#      LOG_CONFIGURE ON
#      LOG_BUILD ON
#      LOG_INSTALL ON)
# # build_external_project()
# # ExternalProject_Add_Step(ZLIB installInternally
# #                          COMMAND cd <BINARY_DIR> && make install
# #                          DEPENDEES install
# #                          ALWAYS 1)
# # install(TARGETS ${GLFW_PROJECT_NAME} EXPORT GLFW3
# #             RUNTIME DESTINATION bin
# #             LIBRARY DESTINATION lib
# #             ARCHIVE DESTINATION lib/static)
# # install(EXPORT ${GLFW_CONFIG_PROJECT_NAME} DESTINATION cmake)
# # ExternalProject_Add_Step(${project} installInternally
# #                          COMMAND cd <BINARY_DIR> && make install
# #                          DEPENDEES install
# #                          ALWAYS 1)
# # ExternalProject_Get_Property(${GLFW_PROJECT_NAME} install_dir)

# externalProject_get_property(project_${GLFW_PROJECT_NAME} source_dir)
# #export(PACKAGE ${GLFW_PROJECT_NAME})
# add_library(${GLFW_PROJECT_NAME} UNKNOWN IMPORTED)

# set_property(TARGET ${GLFW_PROJECT_NAME} PROPERTY IMPORTED_LOCATION ${source_dir}/lib/libglfw.a)

# message("project_${GLFW_PROJECT_NAME} install location" ${source_dir})

# set(GLFW3_INCLUDE_PATH ${glfw_INSTALL_DIR}/include)

# find_path(GLFW3_INCLUDE_PATH GLFW/glfw3.h 
#   ${glfw_INSTALL_DIR}/include 
#     DOC "The directory where GLFW/glfw3.h resides")

# if(WIN32)
# find_library(GLFW3_LIBRARY
#         NAMES glfw3 GLFW
#         PATHS 
#     ${glfw_INSTALL_DIR}/lib
#     DOC "The directory where GLFW/glfw3.h resides")
# else()
# find_library(GLFW3_LIBRARY
#         NAMES libglfw.dylib libglfw.3.dylib libGLFW.a GLFW libGLFW3.a GLFW3 libglfw.so libglfw.so.3 libglfw.so.3.0
#     PATHS
#     ${glfw_INSTALL_DIR}/lib
#     DOC "The directory where GLFW/glfw3.h resides")
# endif()

# if(GLFW3_INCLUDE_PATH AND GLFW3_LIBRARY)
#   set(GLFW_LIBRARIES ${GLFW3_LIBRARY})
#   set(GLFW3_FOUND "YES")
#   message(STATUS "Found GLFW")
# else()
#   set(GLFW3_FOUND "NO")
# endif()

# include_directories(${GLFW3_INCLUDE_PATH})
# link_directories(${GLFW3_LIBRARY})

# message("GLFW3_INCLUDE_PATH: ${GLFW3_INCLUDE_PATH}")
# message("GLFW3_LIBRARY: ${GLFW3_LIBRARY}")