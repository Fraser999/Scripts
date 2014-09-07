#
# Checks a given regex against a given test string using 'string(REGEX MATCH ...)'
#
# Requires https://github.com/toeb/oo-cmake to run.
#
# Invoke by doing:
#   cmake -P "<path to this file>"
#
# or if oo-cmake isn't automatically found:
#   cmake -DOOCMAKE="<path to oo-cmake>" -P "<path to this file>"
#

cmake_minimum_required(VERSION 2.8.7)

find_file(OoCMake NAMES oo-cmake.cmake PATHS "${OOCMAKE}" "${OOCMAKE}/.." "../oo-cmake" "${CMAKE_CURRENT_LIST_DIR}/../oo-cmake")
if(NOT OoCMake)
  get_filename_component(CurrentWorkingDir "." ABSOLUTE)
  string(REPLACE "${CurrentWorkingDir}/" "" RelPath "${CMAKE_CURRENT_LIST_FILE}")
  set(Msg "\n\nFailed to find oo-cmake.cmake.  Specify the path to its folder by doing:\n")
  set(Msg "${Msg}  cmake -DOOCMAKE=\"<path to oo-cmake>\" -P \"${RelPath}\"\n\n")
  message(FATAL_ERROR "${Msg}")
endif()
include("${OoCMake}")


while(1)
  message("\n===============================================\nEnter regex to test ('q' to quit):")
  read_line()
  ans(Regex)
  if("${Regex}" MATCHES "[Qq]")
    break()
  endif()

  while(1)
    message("\nEnter string to test against regex \"${Regex}\" ('q' to quit, 'break' to enter new regex):")
    read_line()
    ans(TestString)

    if("${TestString}" MATCHES "[Qq]" OR "${TestString}" MATCHES "[Bb][Rr][Ee][Aa][Kk]")
      break()
    endif()

    string(REGEX MATCH "${Regex}" Found "${TestString}")

    set(Msg "when running 'string(REGEX MATCH \"${Regex}\" <output variable> \"${TestString}\")'")
    if(Found)
      message("Match ${Msg}")
      message("<output variable>: '${Found}'")
      foreach(i RANGE 9)
        if(CMAKE_MATCH_${i})
          message("\${CMAKE_MATCH_${i}}:  '${CMAKE_MATCH_${i}}'")
        endif()
      endforeach()
    else()
      message("No match ${Msg}")
    endif()
    message("\n")

  endwhile()

  if("${TestString}" MATCHES "[Qq]")
    break()
  endif()
endwhile()
