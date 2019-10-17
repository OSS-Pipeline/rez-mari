CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

include(RezBuild)
include(RezRepository)
include(ExternalProject)

# We split the Mari version string in multiple ones.
string(REPLACE "." ";" MARI_VERSION_LIST ${REZ_BUILD_PROJECT_VERSION})
list(GET MARI_VERSION_LIST 0 MARI_MAJOR_VERSION)
list(GET MARI_VERSION_LIST 1 MARI_MINOR_VERSION)
list(GET MARI_VERSION_LIST 2 MARI_PATCH_VERSION)

set(MARI_PRODUCT_VERSION ${MARI_MAJOR_VERSION}.${MARI_MINOR_VERSION}v${MARI_PATCH_VERSION})

# Mari
rez_set_archive(
    MARI_URL mari/Mari${MARI_PRODUCT_VERSION}-linux-x86-release-64.run
    https://www.foundry.com/products/download_product?file=Mari${MARI_PRODUCT_VERSION}-linux-x86-release-64.run
)

# We will only use a Bash script to deal with the installation as it is provided as a .run file,
# which does not play well with the ExternalProject_Add CMake macro.
execute_process(
    COMMAND
    bash ${CMAKE_SOURCE_DIR}/install.sh ${MARI_URL}
    RESULT_VARIABLE RETURN_CODE
)

# We check that the execute_process() macro terminated properly.
# If not, we abort the process.
if(RETURN_CODE EQUAL "1")
    message(FATAL_ERROR "[CMAKE] Install script returned an error code. Aborting...")
endif()

# We use a bogus CMake "install" step in order to be able to properly finish
# and get out of the CMake script.
install(
    CODE
    "execute_process(
        COMMAND echo \"\n[CMAKE] Mari-${REZ_BUILD_PROJECT_VERSION} PACKAGE SETUP FINISHED!\n\"
    )"
)
