

include(CheckCXXCompilerFlag)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  # using Clang
  message("Setting up for Clang")    
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  # using GCC
  message("Setting up for GCC")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  # using Visual Studio C++
  message("Setting up for MSVC")
  set(warnings "/W4 /WX")# /EHsc")
endif()

if(("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU") OR ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang"))
  # Options

  option(COMPILER_MAKE_VERBOSE "Adds verbose to the makefile" ON)
  option(COMPILER_LINKING_VERBOSE "Add the -v to the compiler linking" OFF)

  if(COMPILER_LINKING_VERBOSE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -v")
  endif(COMPILER_LINKING_VERBOSE)

  if(COMPILER_MAKE_VERBOSE)
    set(CMAKE_VERBOSE_MAKEFILE ON)
  endif(COMPILER_MAKE_VERBOSE)
  
  set(CMAKE_C_FLAGS                "-Wall")
  set(CMAKE_C_FLAGS_DEBUG          "-g -D_DEBUG")
  set(CMAKE_C_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
  set(CMAKE_C_FLAGS_RELEASE        "-O4 -DNDEBUG")
  set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g")

  set(CMAKE_CXX_FLAGS                "-Wall")
  set(CMAKE_CXX_FLAGS_DEBUG          "-g -D_DEBUG ")
  set(CMAKE_CXX_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
  set(CMAKE_CXX_FLAGS_RELEASE        "-O4 -DNDEBUG")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g")
endif(("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU") OR ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang"))

if(("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang") OR ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU") OR (("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel") AND UNIX))
  CHECK_CXX_COMPILER_FLAG("-std=c++98" COMPILER_SUPPORTS_CXX98)
  CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
  CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
  CHECK_CXX_COMPILER_FLAG("-std=c++1y" COMPILER_SUPPORTS_CXX1y)

  if(COMPILER_SUPPORTS_CXX98)
    option(PHOENIX_ENABLE_CXX_98 "Enable C++ 98" OFF)
  endif()
  
  if(COMPILER_SUPPORTS_CXX0X)
    option(PHOENIX_ENABLE_CXX_0X "Enable C++ 0x" OFF)
  endif()
  
  if(COMPILER_SUPPORTS_CXX11)
    option(PHOENIX_ENABLE_CXX_11 "Enable C++ 11" ON)
  endif()
  
  if(COMPILER_SUPPORTS_CXX1y)
    option(PHOENIX_ENABLE_CXX_1Y "Enable C++ 1y" OFF)
  endif()

  if(PHOENIX_ENABLE_CXX_PEDANTIC)
    add_definitions(-pedantic)
  endif()

  if(PHOENIX_ENABLE_CXX_1Y)
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++1y")
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")
  elseif(PHOENIX_ENABLE_CXX_11)
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++11")
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
  elseif(PHOENIX_ENABLE_CXX_0X)
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++0x")
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  elseif(PHOENIX_ENABLE_CXX_98)
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++98")
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++98")
  endif()
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  message("Configuring for Darwin")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
elseif((${CMAKE_SYSTEM_NAME} MATCHES "Linux") AND ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang"))
  message("Configuring for Linux")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
endif()

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" AND NOT MINGW)
  # Test for GCC visibility)
  include(CheckCXXCompilerFlag)
  check_cxx_compiler_flag(-fvisibility=hidden SDK_GCC_VISIBILITY)
  if(SDK_GCC_VISIBILITY)
    # Determine gcc version
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE SDK_GCC_VERSION)
    message(STATUS "Detected g++ ${SDK_GCC_VERSION}")
    message(STATUS "Enabling GCC visibility flags")
    set(SDK_GCC_VISIBILITY_FLAGS "-DSDK_GCC_VISIBILITY -fvisibility=hidden")
    
    # Check if we can safely add -fvisibility-inlines-hidden
    string(TOLOWER "${CMAKE_BUILD_TYPE}" SDK_BUILD_TYPE)
    if(SDK_BUILD_TYPE STREQUAL "debug" AND SDK_GCC_VERSION VERSION_LESS "4.2")
      message(STATUS "Skipping -fvisibility-inlines-hidden due to possible bug in g++ < 4.2")
    else()
      set(SDK_GCC_VISIBILITY_FLAGS "${SDK_GCC_VISIBILITY_FLAGS} -fvisibility-inlines-hidden")
    endif()
  endif()

  # Fix x64 issues on Linux
  if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64" AND NOT APPLE)
    add_definitions(-fPIC)
  endif()  
endif()

#--------------------------------------------------------------------
# Set compiler specific flags
#--------------------------------------------------------------------
if (UNIX)
  add_definitions(-Wall)

  if (BUILD_SHARED_LIBS)
    add_definitions(-fvisibility=hidden)
  endif()
endif()


if (MSVC)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS)
  
  if (NOT USE_MSVC_RUNTIME_LIBRARY_DLL)
    foreach (flag CMAKE_C_FLAGS
      CMAKE_C_FLAGS_DEBUG
      CMAKE_C_FLAGS_RELEASE
      CMAKE_C_FLAGS_MINSIZEREL
      CMAKE_C_FLAGS_RELWITHDEBINFO)

    if (${flag} MATCHES "/MD")
      string(REGEX REPLACE "/MD" "/MT" ${flag} "${${flag}}")
    endif()
    if (${flag} MATCHES "/MDd")
      string(REGEX REPLACE "/MDd" "/MTd" ${flag} "${${flag}}")
    endif()

  endforeach()
endif()
endif()

