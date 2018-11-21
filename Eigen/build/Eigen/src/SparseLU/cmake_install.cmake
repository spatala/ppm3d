# Install script for directory: /media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU

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
   "/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_kernel_bmod.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_panel_dfs.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_relax_snode.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_gemm_kernel.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_copy_to_ucol.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_column_bmod.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_heap_relax_snode.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_panel_bmod.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_pruneL.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_Memory.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLUImpl.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_column_dfs.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_pivotL.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_Utils.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_Structs.h;/usr/local/include/eigen3/Eigen/src/SparseLU/SparseLU_SupernodalMatrix.h")
  IF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
  IF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  ENDIF (CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
FILE(INSTALL DESTINATION "/usr/local/include/eigen3/Eigen/src/SparseLU" TYPE FILE FILES
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_kernel_bmod.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_panel_dfs.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_relax_snode.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_gemm_kernel.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_copy_to_ucol.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_column_bmod.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_heap_relax_snode.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_panel_bmod.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_pruneL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_Memory.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLUImpl.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_column_dfs.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_pivotL.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_Utils.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_Structs.h"
    "/media/valuedc/lin/prog/c++/Eigen/Eigen/src/SparseLU/SparseLU_SupernodalMatrix.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")

