find_path(FreeSTDC_ROOT_DIR NAMES CMakeLists.txt HINTS ${PbOS_SOURCE_DIR}/lib/freestdc)
find_path(FreeSTDC_INCLUDE_DIR NAMES freestdc.h.in HINTS ${FreeSTDC_ROOT_DIR}/include)

include(ExternalProject)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    FreeSTDC
	FOUND_VAR FreeSTDC_FOUND
    REQUIRED_VARS FreeSTDC_ROOT_DIR FreeSTDC_INCLUDE_DIR)

if(FreeSTDC_FOUND)
	function(add_freestdc_build target_name binary_dir)
		set(FREESTDC_TARGET_NAME ${target_name})
		add_subdirectory(${FreeSTDC_ROOT_DIR} ${binary_dir})
	endfunction()
endif()
