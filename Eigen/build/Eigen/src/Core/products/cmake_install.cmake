# Install script for directory: /media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products

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
   "/usr/local/include/eigen3/Eigen/src/Core/products/GeneralMatrixMatrixTriangular.h;/usr/local/include/eigen3/Eigen/src/Core/products/Parallelizer.h;/usr/local/include/eigen3/Eigen/src/Core/products/SelfadjointMatrixVector.h;/usr/local/include/eigen3/Eigen/src/Core/products/GeneralMatrixMatrix_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/GeneralMatrixVector_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/TriangularSolverMatrix.h;/usr/local/include/eigen3/Eigen/src/Core/products/CoeffBasedProduct.h;/usr/local/include/eigen3/Eigen/src/Core/products/TriangularMatrixVector_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/TriangularSolverMatrix_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/SelfadjointMatrixVector_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/GeneralMatrixVector.h;/usr/local/include/eigen3/Eigen/src/Core/products/SelfadjointRank2Update.h;/usr/local/include/eigen3/Eigen/src/Core/products/TriangularSolverVector.h;/usr/local/include/eigen3/Eigen/src/Core/products/GeneralMatrixMatrix.h;/usr/local/include/eigen3/Eigen/src/Core/products/TriangularMatrixVector.h;/usr/local/include/eigen3/Eigen/src/Core/products/TriangularMatrixMatrix.h;/usr/local/include/eigen3/Eigen/src/Core/products/SelfadjointMatrixMatrix_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/TriangularMatrixMatrix_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/GeneralBlockPanelKernel.h;/usr/local/include/eigen3/Eigen/src/Core/products/GeneralMatrixMatrixTriangular_MKL.h;/usr/local/include/eigen3/Eigen/src/Core/products/SelfadjointProduct.h;/usr/local/include/eigen3/Eigen/src/Core/products/SelfadjointMatrixMatrix.h")
  IF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
  IF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
FILE(INSTALL DESTINATION "/usr/local/include/eigen3/Eigen/src/Core/products" TYPE FILE FILES
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/GeneralMatrixMatrixTriangular.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/Parallelizer.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/SelfadjointMatrixVector.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/GeneralMatrixMatrix_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/GeneralMatrixVector_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/TriangularSolverMatrix.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/CoeffBasedProduct.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/TriangularMatrixVector_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/TriangularSolverMatrix_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/SelfadjointMatrixVector_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/GeneralMatrixVector.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/SelfadjointRank2Update.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/TriangularSolverVector.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/GeneralMatrixMatrix.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/TriangularMatrixVector.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/TriangularMatrixMatrix.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/SelfadjointMatrixMatrix_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/TriangularMatrixMatrix_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/GeneralBlockPanelKernel.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/GeneralMatrixMatrixTriangular_MKL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/SelfadjointProduct.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/Core/products/SelfadjointMatrixMatrix.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")

