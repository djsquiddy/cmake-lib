find_package(SDL2)
include_directories(${SDL2_INCLUDE_DIRS})

if(NOT SDL2_FOUND)
    message(ERROR " SDL2 not found!") 
else(NOT SDL2_FOUND)
    message("SDL2 found!") 
endif(NOT SDL2_FOUND)

find_package(SDL2_image REQUIRED)
include_directories(${SDL2_INCLUDE_DIR})

if(NOT SDL2IMAGE_FOUND)
    message(ERROR " SDL2_image not found!") 
else(NOT SDL2IMAGE_FOUND)
    message("SDL2_image found!") 
endif(NOT SDL2IMAGE_FOUND)

message("${SDL2_LIBRARY} ${SDL2IMAGE_LIBRARY}")
include_directories(${SDL2_INCLUDE_DIRS} ${SDL2IMAGE_INCLUDE_DIRS})
