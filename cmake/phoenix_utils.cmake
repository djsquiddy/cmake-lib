
######################################################################################################################################
# Util functions to make our lives easier
######################################################################################################################################
# Function to list all header files in the current directory, recursing into sub-directories
# HEADER_FILES - To be filled with the found header files
function(sdk_list_header_files HEADER_FILES)
    file(GLOB_RECURSE HEADER_FILES_TMP "*.h" "*.hpp" "*.inl" "*.pch")
    set(HEADER_FILES ${HEADER_FILES_TMP} PARENT_SCOPE)
endfunction()
 
# Function to list all source files in the current directory, recursing into sub-directories
# SOURCE_FILES - To be filled with the found source files
function(sdk_list_source_files HEADER_FILES)
    file(GLOB_RECURSE SOURCE_FILES_TMP "*.c" "*.cpp")
    set(SOURCE_FILES ${SOURCE_FILES_TMP} PARENT_SCOPE)
endfunction()

# Function to setup some standard project items
# PROJECTNAME - The name of the project being setup
# TARGETDIR - The target directory for output files (relative to CMAKE_SOURCE_DIR)
function(sdk_setup_project_common project_name)
    # Set the Debug and Release names
    set_target_properties(${project_name} PROPERTIES DEBUG_OUTPUT_NAME ${project_name}_d RELEASE_OUTPUT_NAME ${project_name})
    cotire(${project_name})
endfunction()

set(PHOENIX_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")
set(PHOENIX_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib")

file(MAKE_DIRECTORY ${PHOENIX_RUNTIME_OUTPUT_DIRECTORY})

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${PHOENIX_RUNTIME_OUTPUT_DIRECTORY})
file(MAKE_DIRECTORY ${PHOENIX_LIBRARY_OUTPUT_DIRECTORY})

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${PHOENIX_LIBRARY_OUTPUT_DIRECTORY})

# First for the generic no-config case (e.g. with mingw)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PHOENIX_RUNTIME_OUTPUT_DIRECTORY})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PHOENIX_LIBRARY_OUTPUT_DIRECTORY})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PHOENIX_LIBRARY_OUTPUT_DIRECTORY})

# Second, for multi-config builds (e.g. msvc)
foreach(OUTPUTCONFIG ${CMAKE_CONFIGURATION_TYPES})
	string(TOUPPER ${OUTPUTCONFIG} OUTPUTCONFIG)
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${OUTPUTCONFIG} ${PHOENIX_RUNTIME_OUTPUT_DIRECTORY})
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${OUTPUTCONFIG} ${PHOENIX_LIBRARY_OUTPUT_DIRECTORY})
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${OUTPUTCONFIG} ${PHOENIX_LIBRARY_OUTPUT_DIRECTORY})
endforeach(OUTPUTCONFIG CMAKE_CONFIGURATION_TYPES)

# Function to setup some project items for an executable or DLL
# PROJECTNAME - The name of the project being setup
function(sdk_setup_project_bin PROJECTNAME)
    sdk_setup_project_common(${PROJECTNAME})
endfunction()

# Function to setup some project items for static library
# PROJECTNAME - The name of the project being setup
function(sdk_setup_project_lib PROJECTNAME)
    sdk_setup_project_common(${PROJECTNAME})
endfunction()

# Function to setup some project items for shared library
# PROJECTNAME - The name of the project being setup
function(sdk_setup_project_shared PROJECTNAME)
    sdk_setup_project_common(${PROJECTNAME})
endfunction()
######################################################################################################################################

######################################################################################################################################
# Set up the basic build environment
######################################################################################################################################
if(CMAKE_BUILD_TYPE STREQUAL "")
    # CMake defaults to leaving CMAKE_BUILD_TYPE empty. This screws up differentiation between debug and release builds.
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "Choose the type of build, options are: None (CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif()

# Set compiler specific build flags
if(CMAKE_COMPILER_IS_GNUCXX)
    add_definitions(-msse)
endif()

if(MSVC)
    if(CMAKE_BUILD_TOOL STREQUAL "nmake")
        # Set variable to state that we are using nmake makefiles
        set(NMAKE TRUE)
    endif()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /fp:fast")
    # Enable intrinsics on MSVC in debug mode
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Oi")
	
    if(CMAKE_CL_64)
        # Visual Studio bails out on debug builds in 64bit mode unless this flag is set
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /bigobj")
        set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /bigobj")
    endif()
endif(MSVC)

if(MINGW)
    add_definitions(-D_WIN32_WINNT=0x0500)
endif()
######################################################################################################################################
