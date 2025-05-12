cmake_minimum_required(VERSION 3.16)
project(HelloWorldApp VERSION 1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# Find Qt package
find_package(Qt6 COMPONENTS Core Gui Qml Quick REQUIRED)
if(NOT Qt6_FOUND)
    find_package(Qt6 6.4 COMPONENTS Core Gui Qml Quick REQUIRED)
endif()

# Include source directory
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

qt_add_executable(HelloWorldApp
    src/main.cpp
    src/resources.qrc
)

set_target_properties(HelloWorldApp PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(HelloWorldApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

# Install rules
install(TARGETS HelloWorldApp
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
) 