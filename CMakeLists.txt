#-----------------------------------------------------------------------------------------------------------------------
# Information
#-----------------------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.5...4.1)
project(Utilities LANGUAGES NONE)

#-----------------------------------------------------------------------------------------------------------------------
# Includes
#-----------------------------------------------------------------------------------------------------------------------
include(GNUInstallDirs)
include(cmake/dep_mgr.cmake)

#-----------------------------------------------------------------------------------------------------------------------
# Install Rules
#-----------------------------------------------------------------------------------------------------------------------
# Install shell scripts
install(
        DIRECTORY ${CMAKE_SOURCE_DIR}/scripts/
        DESTINATION ${CMAKE_INSTALL_BINDIR}/scripts/
        FILES_MATCHING
            PATTERN "*.sh"
)

# Install CMake scripts
install(
        DIRECTORY ${CMAKE_SOURCE_DIR}/cmake/
        DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/
        FILES_MATCHING
            PATTERN "*.cmake"
)

# Install .clang-format
install(
        DIRECTORY ${CMAKE_SOURCE_DIR}/
        DESTINATION ${CMAKE_INSTALL_DATADIR}/clang/
)

