SET(assimp_SEARCH_PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw # Fink
  /opt/local # DarwinPorts
  /opt/csw # Blastwave
  /opt
  $ENV{PhoenixLib}
  $ENV{PhoenixInclude}
  )

FIND_PATH(
  assimp_INCLUDE_DIRS
  PATH_SUFFIXES include/assimp include assimp
  NAMES postprocess.h scene.h version.h config.h cimport.h
  PATHS ${assimp_SEARCH_PATHS}
  )

FIND_LIBRARY(
  assimp_LIBRARIES
  NAMES assimp
  PATHS ${assimp_SEARCH_PATHS}
  )

IF (NOT assimp_INCLUDE_DIRS)
  MESSAGE(STATUS "Couldn't find assimp include directories!")
ENDIF(NOT assimp_INCLUDE_DIRS)
IF (NOT assimp_LIBRARIES)
  MESSAGE(STATUS "Couldn't find assimp libraries!")
ENDIF(NOT assimp_LIBRARIES)

IF (assimp_INCLUDE_DIRS AND assimp_LIBRARIES)
  SET(assimp_FOUND TRUE)
ENDIF (assimp_INCLUDE_DIRS AND assimp_LIBRARIES)

IF (assimp_FOUND)
  IF (NOT assimp_FIND_QUIETLY)
    MESSAGE(STATUS "Found asset importer library: ${assimp_LIBRARIES}")
  ENDIF (NOT assimp_FIND_QUIETLY)
ELSE (assimp_FOUND)
  IF (assimp_FIND_REQUIRED)
    MESSAGE(FATAL_ERROR "Could not find asset importer library")
  ENDIF (assimp_FIND_REQUIRED)
ENDIF (assimp_FOUND)
