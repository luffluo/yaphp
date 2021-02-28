cmake_minimum_required(VERSION 3.4)
project(yaphp)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_COMPILER clang++)

find_package(FLEX REQUIRED)
set(FlexOutput ${CMAKE_SOURCE_DIR}/src/Zend/zend_language_scanner.cc)
if(FLEX_FOUND)
    add_custom_command(
      OUTPUT ${FlexOutput}
      COMMAND ${FLEX_EXECUTABLE}
              --outfile=${FlexOutput}
              ${CMAKE_SOURCE_DIR}/src/Zend/zend_language_scanner.l
      COMMENT "Generating zend_language_scanner.cc"
    )
endif()

find_package(BISON REQUIRED)
set(BisonOutput ${CMAKE_SOURCE_DIR}/src/Zend/zend_language_parser.cc)
if(BISON_FOUND)
    add_custom_command(
      OUTPUT ${BisonOutput}
      COMMAND ${BISON_EXECUTABLE}
              --defines=${CMAKE_SOURCE_DIR}/src/Zend/zend_language_parser.h
              --output=${BisonOutput}
              ${CMAKE_SOURCE_DIR}/src/Zend/zend_language_parser.y
      COMMENT "Generating zend_language_parser.cc"
    )
endif()

add_executable(yaphp
    ${FlexOutput}
    ${BisonOutput}
)

include_directories(BEFORE ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_options(yaphp PUBLIC ${CMAKE_CXX_FLAGS} -Wall -Wno-deprecated-register -O0 -g)

message(STATUS "summary of build options:
    Install prefix:  ${CMAKE_INSTALL_PREFIX}
    Target system:   ${CMAKE_SYSTEM_NAME}
    Compiler:
      CXX compiler:    ${CMAKE_CXX_COMPILER}
")