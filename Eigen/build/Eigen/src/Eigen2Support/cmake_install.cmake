# Install script for directory: /media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support

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
   "/usr/local/include/eigen3/Eigen/src/Eigen2Support/Macros.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/MathFunctions.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/CwiseOperators.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/LU.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/QR.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/Cwise.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/Meta.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/Memory.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/TriangularSolver.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/LeastSquares.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/Block.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/VectorBlock.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/Minor.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/Lazy.h;/usr/local/include/eigen3/Eigen/src/Eigen2Support/SVD.h")
  IF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
  IF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
FILE(INSTALL DESTINATION "/usr/local/include/eigen3/Eigen/src/Eigen2Support" TYPE FILE FILES
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/Macros.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/MathFunctions.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/CwiseOperators.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/LU.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/QR.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/Cwise.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/Meta.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/Memory.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/TriangularSolver.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/LeastSquares.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/Block.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/VectorBlock.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/Minor.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/Lazy.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Eigen2Support/SVD.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/media/valuedc/lin/prog/c++/Eigen/build/Eigen/src/Eigen2Support/Geometry/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

