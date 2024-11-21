find_path(PbOSCommon_ROOT_DIR NAMES include/pbos/common.h HINTS ${PbOS_SOURCE_DIR}/common)
find_path(PbOSCommon_INCLUDE_DIR NAMES pbos/common.h HINTS ${PbOSCommon_ROOT_DIR}/include)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    PbOSCommon
	FOUND_VAR PbOSCommon_FOUND
    REQUIRED_VARS PbOSCommon_ROOT_DIR PbOSCommon_INCLUDE_DIR)

if(PbOSCommon_FOUND)
endif()
