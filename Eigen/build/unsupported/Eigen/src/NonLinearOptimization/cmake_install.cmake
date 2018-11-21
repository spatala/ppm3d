# Install script for directory: /media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "Release")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/chkder.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/HybridNonLinearSolver.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/rwupdt.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/covar.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/fdjac1.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/r1mpyq.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/LevenbergMarquardt.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/r1updt.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/dogleg.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/qrsolv.h;/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization/lmpar.h")
  IF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
  IF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
FILE(INSTALL DESTINATION "/usr/local/include/eigen3/unsupported/Eigen/src/NonLinearOptimization" TYPE FILE FILES
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/chkder.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/HybridNonLinearSolver.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/rwupdt.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/covar.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/fdjac1.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/r1mpyq.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/LevenbergMarquardt.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/r1updt.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/dogleg.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/qrsolv.h"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/src/NonLinearOptimization/lmpar.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")

