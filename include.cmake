FILE(WRITE "${CMAKE_BINARY_DIR}/set_freetype_library.cmake" "")
if(MSVC)
	CGET_HAS_DEPENDENCY(iconv NUGET_PACKAGE libiconv GIT git://git.savannah.gnu.org/libiconv.git VERSION v1.14 NO_FIND_PACKAGE ALLOW_SYSTEM)

	#Freetype has a bad config file; keyed to a very particular version of the library. This fixs that.
	SET(FREETYPE_LIBRARY "${CGET_INSTALL_DIR}/lib/freetype271.lib")

	# We have to propagate the fix to the poppler make file
	STRING(REPLACE " " "\\ " FREETYPE_LIBRARY "${FREETYPE_LIBRARY}")
	FILE(APPEND "${CMAKE_BINARY_DIR}/set_freetype_library.cmake" "SET(FREETYPE_LIBRARY \"${FREETYPE_LIBRARY}\" CACHE STRING \"\" FORCE)\n")
	FILE(APPEND "${CMAKE_BINARY_DIR}/set_freetype_library.cmake" "SET(ICONV_CONST \"const\" CACHE STRING \"\" FORCE)")
else()
	CGET_HAS_DEPENDENCY(Fontconfig GIT git://anongit.freedesktop.org/fontconfig VERSION 2.12.1 NO_FIND_PACKAGE BREW_PACKAGE Fontconfig)
endif()

CGET_HAS_DEPENDENCY(Freetype NUGET_PACKAGE FreeType GIT git://git.sv.nongnu.org/freetype/freetype2.git VERSION VER-2-7-1 NO_FIND_VERSION OPTIONS -DBUILD_SHARED_LIBS:BOOL=true)
CGET_EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E copy "${CGET_INSTALL_DIR}/lib/freetype271.lib" "${CGET_INSTALL_DIR}/lib/freetype.lib")
CGET_EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E copy "${CGET_INSTALL_DIR}/lib/freetype271d.lib" "${CGET_INSTALL_DIR}/lib/freetyped.lib")