## Useful commands  ============================================================
# Configure template files
macro(cmaker_configure_android_project)
  set(IN_LIBS ${${LIBS}})
  set(${LIBS} "")
  foreach(CULL_LIB ${IN_LIBS})
    get_filename_component(FN "${CULL_LIB}" NAME)
    list(APPEND ${LIBS} ${FN})
  endforeach()
endmacro(cmaker_configure_android_project)
