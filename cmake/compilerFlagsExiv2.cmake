# These flags apply to exiv2lib and samples, but not to the xmp code

if (COMPILER_IS_GCC OR COMPILER_IS_CLANG) # MINGW, Linux, APPLE, CYGWIN
    check_c_compiler_flag(-Werror                            COMPILE_FLAG_WERROR     )
    check_c_compiler_flag(-Wno-error=deprecated-declarations COMPILE_ERROR_DEP       )

    if ( EXIV2_TEAM_WARNINGS_AS_ERRORS )
        if ( COMPILE_FLAG_WERROR )
            add_compile_options(-Werror)
        endif()
        if ( COMPILE_ERROR_DEP )
            add_compile_options(-Wno-error=deprecated-declarations)
        endif()
    endif()

    # Note that this is intended to be used only by Exiv2 developers/contributors.
    if ( EXIV2_TEAM_EXTRA_WARNINGS )
        check_c_compiler_flag(-Wextra                    COMPILE_FLAG_WEXTRA            )
        check_c_compiler_flag(-Wlogical-op               COMPILE_FLAG_WLOGICAL_OP       )
        check_c_compiler_flag(-Wdouble-promotion         COMPILE_FLAG_WDOUBLE_PROMOTION )
        check_c_compiler_flag(-Wshadow                   COMPILE_FLAG_WSHADOW           )
        check_c_compiler_flag(-Wuseless-cast             COMPILE_FLAG_WUSELESS_CAST     )
        check_c_compiler_flag(-Wpointer-arith            COMPILE_FLAG_WPOINTER_ARITH    )
        check_c_compiler_flag(-Wformat=2                 COMPILE_FLAG_WFORMAT_2         )
        check_c_compiler_flag(-Warray-bounds=2           COMPILE_FLAG_WARRAY_BOUNDS_2   )
        check_c_compiler_flag(-Wduplicated-cond          COMPILE_FLAG_WDUPLICATED_COND  )
        check_c_compiler_flag(-Wduplicated-branches      COMPILE_FLAG_WDUPLICATED_BRAN  )
        check_c_compiler_flag(-Wrestrict                 COMPILE_FLAG_WRESTRICT         )
        
        if ( COMPILER_IS_GCC )
            if ( COMPILE_FLAG_WEXTRA )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wextra")
            endif()
            if ( COMPILE_FLAG_WLOGICAL_OP )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wlogical-op")
            endif()
            if ( COMPILE_FLAG_WDOUBLE_PROMOTION )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wdouble-promotion")
            endif()
            if ( COMPILE_FLAG_WSHADOW )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wshadow")
            endif()
            if ( COMPILE_FLAG_WUSELESS_CAST )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wuseless-cast")
            endif()
            if ( COMPILE_FLAG_WPOINTER_ARITH )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wpointer-arith") # This warning is also enabled by -Wpedantic
            endif()
            if ( COMPILE_FLAG_WFORMAT_2 )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wformat=2")
            endif()
            if ( COMPILE_FLAG_WARRAY_BOUNDS_2 )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Warray-bounds=2")
            endif()
            if ( COMPILE_FLAG_WDUPLICATED_COND )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wduplicated-cond")
            endif()
            if ( COMPILE_FLAG_WDUPLICATED_BRAN )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wduplicated-branches")
            endif()
            if ( COMPILE_FLAG_WRESTRICT )
                string(CONCAT EXTRA_COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}" -Wrestrict")
            endif ()
        endif ()

        if ( COMPILER_IS_CLANG )
            check_c_compiler_flag(-Wassign-enum               COMPILE_FLAG_WASSIGN_ENUM       )
            check_c_compiler_flag(-Wmicrosoft                 COMPILE_FLAG_WMICROSOFT         )
            check_c_compiler_flag(-Wcomments                  COMPILE_FLAG_WCOMMENTS          )
            check_c_compiler_flag(-Wconditional-uninitialized COMPILE_FLAG_WCONDITIONAL_UNINIT)
            check_c_compiler_flag(-Wdirect-ivar-access        COMPILE_FLAG_WDIRECT_IVAR_ACCESS)
            check_c_compiler_flag(-Weffc++                    COMPILE_FLAG_WEFFCPP            )
            check_c_compiler_flag(-Wcomma                     COMPILE_FLAG_WCOMMA             )

            # https://clang.llvm.org/docs/DiagnosticsReference.html
            # These variables are at least available since clang 3.9.1
            if ( COMPILE_FLAG_WEXTRA )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wextra")
            endif()
            if ( COMPILE_FLAG_WSHADOW )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wshadow")
            endif()
            if ( COMPILE_FLAG_WASSIGN_ENUM )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wassign-enum")
            endif()
            if ( COMPILE_FLAG_WMICROSOFT )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wmicrosoft")
            endif()
            if ( COMPILE_FLAG_WCOMMENTS )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wcomments")
            endif()
            if ( COMPILE_FLAG_CONDITIONAL_UNINIT )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wconditional-uninitialized")
            endif()
            if ( COMPILE_FLAG_WDIRECT_IVAR_ACCESS )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wdirect-ivar-access")
            endif()
            if ( COMPILE_FLAG_WEFFCPP )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Weffc++")
            endif()
            if ( COMPILE_FLAG_WPOINTER_ARITH )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wpointer-arith")
            endif()
            if ( COMPILE_FLAG_WFORMAT_2 )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wformat=2")
            endif()
            if ( COMPILE_FLAG_WDOUBLE_PROMOTION )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wdouble-promotion")
            endif()
            if ( COMPILE_FLAG_WCOMMA )
                string(CONCAT EXTRA_COMPILE_FLAGS " -Wcomma")
            endif()

            # These two raises lot of warnings. Use them wisely
            #" -Wconversion"
            #" -Wold-style-cast"
        endif()
    endif()
endif()

if (MSVC)
    if ( EXIV2_TEAM_WARNINGS_AS_ERRORS )
        add_compile_options(/WX)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /WX")
        set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} /WX")
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /WX")
    endif()
endif()
