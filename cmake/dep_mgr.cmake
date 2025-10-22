function(fetch_repo NAME REPO TAG)
    # If FetchContent is not included...
    if(NOT FetchDeclare)
        include(FetchContent)
    endif()

    # If the content name is not specified...
    set(CONTENT_NAME "")
    if(NOT CONTENT_NAME)
        # Prompt the user to provide the content name
        message(FATAL_ERROR "\${CONTENT_NAME} was not specified")
    endif()

    # If the Github repository was not specified...
    set(GIT_REPO_VAL "")
    if (NOT GIT_REPO_VAL)
        # Prompt the user to provide the Github repository
        message(FATAL_ERROR "\${GIT_REPO_VAL} was not specified")
    endif()

    # If the Github tag was not specified...
    set(GIT_TAG_VAL "")
    if (NOT GIT_TAG_VAL)
        # Set the tag to main
        set(GIT_TAG_VAL "main")
    endif()

    # Fetch the Github repository
    FetchContent_Declare(
            NAME
            GIT_REPOSITORY REPO
            GIT_TAG TAG
    )

    # Make the Github repository available for use
    FetchContent_MakeAvailable(NAME)
endfunction()

function(install_dep DEP_NAME BIN_DIR)
    # If the dependency name was not specified...
    if(NOT DEP_NAME)
        message(FATAL_ERROR "\${DEP_NAME} was not specified")
    endif()

    # If the source directory containing the CMakeLists.txt
    # file is not specified...
    if(NOT BIN_DIR)
        # Set the build directory to the build directory of
        # the top level CMakeLists.txt file
        set(BIN_DIR "${CMAKE_BINARY_DIR}")
    endif()

    # Install the dependency
    execute_process(
            COMMAND ${CMAKE_COMMAND} -P "${BIN_DIR}/_deps/${DEP_NAME}-build/cmake_install.cmake"
    )

    # Remove the dependency

endfunction()
