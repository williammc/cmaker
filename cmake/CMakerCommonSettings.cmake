set(CMakerCommonSettings_CALLED FALSE)

if(NOT CMakerCommonSettings_CALLED)
  ## General settings ==========================================================
  # postfix, based on type
  set(CMAKE_DEBUG_POSTFIX "_d" CACHE STRING "postfix applied to debug build of libraries")
  set(CMAKE_RELEASE_POSTFIX "" CACHE STRING "postfix applied to release build of libraries")
  set(CMAKE_RELWITHDEBINFO_POSTFIX "_rd" CACHE STRING "postfix applied to release-with-debug-information libraries")
  set(CMAKE_MINSIZEREL_POSTFIX "_s" CACHE STRING "postfix applied to minimium-size-build libraries")

  # work out the postfix; required where we use OUTPUT_NAME
  if(CMAKE_BUILD_TYPE MATCHES Release)
    set(EXE_POSTFIX)
  elseif(CMAKE_BUILD_TYPE MATCHES Debug)
    set(EXE_POSTFIX ${CMAKE_DEBUG_POSTFIX})
  elseif(CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
    set(EXE_POSTFIX ${CMAKE_RELWITHDEBINFO_POSTFIX})
  elseif(CMAKE_BUILD_TYPE MATCHES MinSizeRel)
    set(EXE_POSTFIX ${CMAKE_MINSIZEREL_POSTFIX})
  endif(CMAKE_BUILD_TYPE MATCHES Release)

  if(NOT THE_PROJECT_ROOT OR THE_PROJECT_ROOT STREQUAL "")
    cmaker_print_error("Please set THE_PROJECT_ROOT to your project root!!!")
  endif()

  if(NOT THE_LIB_RUNTIME_OUTPUT_DIRECTORY)
    set(THE_LIB_RUNTIME_OUTPUT_DIRECTORY ${THE_PROJECT_ROOT}/bin CACHE PATH "Target for the binaries")
    set(THE_LIB_LIBRARY_OUTPUT_DIRECTORY ${THE_PROJECT_ROOT}/lib CACHE PATH "Target for the libraries")
  endif()
  link_directories(${THE_LIB_LIBRARY_OUTPUT_DIRECTORY})

  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${THE_LIB_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${THE_LIB_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${THE_LIB_RUNTIME_OUTPUT_DIRECTORY})

  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${THE_LIB_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${THE_LIB_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${THE_LIB_RUNTIME_OUTPUT_DIRECTORY})


  # Useful Windows paths settings ==============================================
  # Useful paths configuration for windows 
  if(WIN32)
    if(MSVC)
      if(CMAKE_CL_64)
        set(StructuralModeling_ARCH x64)
      else()
        set(StructuralModeling_ARCH x86)
      endif()
      if(MSVC_VERSION EQUAL 1400)
        set(StructuralModeling_RUNTIME vc8)
      elseif(MSVC_VERSION EQUAL 1500)
        set(StructuralModeling_RUNTIME vc9)
      elseif(MSVC_VERSION EQUAL 1600)
        set(StructuralModeling_RUNTIME vc10)
        get_filename_component(VC_IDE_PATH $ENV{VS100COMNTOOLS}/../IDE ABSOLUTE)
      elseif(MSVC_VERSION EQUAL 1700)
        set(StructuralModeling_RUNTIME vc11)
        get_filename_component(VC_IDE_PATH $ENV{VS110COMNTOOLS}/../IDE ABSOLUTE)
      elseif(MSVC_VERSION EQUAL 1800)
        set(StructuralModeling_RUNTIME vc12)
        get_filename_component(VC_IDE_PATH $ENV{VS120COMNTOOLS}/../IDE ABSOLUTE)
      endif()
    endif()
    configure_file("${CMAKER_ROOT}/scripts/set_paths.bat.in" 
                   "${CMAKE_CURRENT_BINARY_DIR}/set_paths.bat")
    configure_file("${CMAKER_ROOT}/scripts/set_paths.bat.in" 
                   "${THE_LIB_RUNTIME_OUTPUT_DIRECTORY}/set_paths.bat")
    configure_file("${CMAKER_ROOT}/scripts/set_paths_and_run_vc.bat.in"
                   "${CMAKE_CURRENT_BINARY_DIR}/set_paths_and_run_vc.bat")
  endif()
endif(NOT CMakerCommonSettings_CALLED)