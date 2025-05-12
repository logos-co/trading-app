cmake_minimum_required(VERSION 3.16)
project(HelloWorldApp VERSION 1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# Find Qt package
find_package(Qt6 COMPONENTS Core Gui Qml Quick QuickControls2 REQUIRED)
if(NOT Qt6_FOUND)
    find_package(Qt6 6.4 COMPONENTS Core Gui Qml Quick QuickControls2 REQUIRED)
endif()

# StatusQ setup
set(STATUSQ_BUILD_SANDBOX OFF)
set(STATUSQ_BUILD_SANITY_CHECKER OFF)
set(STATUSQ_BUILD_TESTS OFF)
set(STATUSQ_SHADOW_BUILD OFF)

# Include source directory
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

# Add SortFilterProxyModel subdirectory
add_subdirectory(vendor/SortFilterProxyModel)

# Add QZXing subdirectory
set(QZXING_USE_QML ON)
add_subdirectory(vendor/qzxing/src)

# Define our target
qt_add_executable(HelloWorldApp
    src/main.cpp
    src/resources.qrc
)

set_target_properties(HelloWorldApp PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Manually import StatusQ
target_include_directories(HelloWorldApp PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/src/StatusQ/include
)

# Link with Qt libraries and our libraries
target_link_libraries(HelloWorldApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    SortFilterProxyModel
    qzxing
)

# Set QML import path for development
set_property(TARGET HelloWorldApp PROPERTY QT_QML_IMPORT_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Set runtime QML import path
set_property(TARGET HelloWorldApp APPEND PROPERTY QML_IMPORT_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Install rules
install(TARGETS HelloWorldApp
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
) 