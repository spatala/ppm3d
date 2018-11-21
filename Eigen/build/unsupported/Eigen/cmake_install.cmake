# Install script for directory: /media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen

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
   "/usr/local/include/eigen3/unsupported/Eigen/AdolcForward;/usr/local/include/eigen3/unsupported/Eigen/AlignedVector3;/usr/local/include/eigen3/unsupported/Eigen/ArpackSupport;/usr/local/include/eigen3/unsupported/Eigen/AutoDiff;/usr/local/include/eigen3/unsupported/Eigen/BVH;/usr/local/include/eigen3/unsupported/Eigen/FFT;/usr/local/include/eigen3/unsupported/Eigen/IterativeSolvers;/usr/local/include/eigen3/unsupported/Eigen/KroneckerProduct;/usr/local/include/eigen3/unsupported/Eigen/LevenbergMarquardt;/usr/local/include/eigen3/unsupported/Eigen/MatrixFunctions;/usr/local/include/eigen3/unsupported/Eigen/MoreVectorization;/usr/local/include/eigen3/unsupported/Eigen/MPRealSupport;/usr/local/include/eigen3/unsupported/Eigen/NonLinearOptimization;/usr/local/include/eigen3/unsupported/Eigen/NumericalDiff;/usr/local/include/eigen3/unsupported/Eigen/OpenGLSupport;/usr/local/include/eigen3/unsupported/Eigen/Polynomials;/usr/local/include/eigen3/unsupported/Eigen/Skyline;/usr/local/include/eigen3/unsupported/Eigen/SparseExtra;/usr/local/include/eigen3/unsupported/Eigen/Splines")
  IF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
  IF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
FILE(INSTALL DESTINATION "/usr/local/include/eigen3/unsupported/Eigen" TYPE FILE FILES
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/AdolcForward"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/AlignedVector3"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/ArpackSupport"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/AutoDiff"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/BVH"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/FFT"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/IterativeSolvers"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/KroneckerProduct"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/LevenbergMarquardt"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/MatrixFunctions"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/MoreVectorization"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/MPRealSupport"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/NonLinearOptimization"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/NumericalDiff"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/OpenGLSupport"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/Polynomials"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/Skyline"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/SparseExtra"
    "/media/valuedc/lin/prog/c++/Eigen/unsupported/Eigen/Splines"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/media/valuedc/lin/prog/c++/Eigen/build/unsupported/Eigen/src/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

