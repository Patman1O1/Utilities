#-----------------------------------------------------------------------------------------------------------------------
# Information
#-----------------------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.5...4.1)
project(Utilities LANGUAGES NONE)

#-----------------------------------------------------------------------------------------------------------------------
# Includes
#-----------------------------------------------------------------------------------------------------------------------
include(GNUInstallDirs)

#-----------------------------------------------------------------------------------------------------------------------
# Install Rules
#-----------------------------------------------------------------------------------------------------------------------
# Install shell scripts
install(
        DIRECTORY ${CMAKE_SOURCE_DIR}/scripts
        DESTINATION /usr/local/bin/scripts
        FILES_MATCHING
            PATTERN "*.sh"
)

# Install CMake scripts
install(
        DIRECTORY ${CMAKE_SOURCE_DIR}/cmake
        DESTINATION /usr/local/share/cmake
        FILES_MATCHING
            PATTERN "*.cmake"
)

# Install .clang-format
install(
        DIRECTORY ${CMAKE_SOURCE_DIR}
        DESTINATION /etc/clang-format
        FILES_MATCHING
            PATTERN ".clang-format"
)


#-----------------------------------------------------------------------------------------------------------------------
# Uninstall Target
#-----------------------------------------------------------------------------------------------------------------------
configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/templates/cmake_uninstall.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
        @ONLY
)
add_custom_target(uninstall
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake
)