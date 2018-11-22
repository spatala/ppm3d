# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /media/valuedc/lin/prog/c++/Eigen

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /media/valuedc/lin/prog/c++/Eigen/build

# Include any dependencies generated for this target.
include blas/testing/CMakeFiles/dblat2.dir/depend.make

# Include the progress variables for this target.
include blas/testing/CMakeFiles/dblat2.dir/progress.make

# Include the compile flags for this target's objects.
include blas/testing/CMakeFiles/dblat2.dir/flags.make

blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o: blas/testing/CMakeFiles/dblat2.dir/flags.make
blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o: ../blas/testing/dblat2.f
	$(CMAKE_COMMAND) -E cmake_progress_report /media/valuedc/lin/prog/c++/Eigen/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building Fortran object blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o"
	cd /media/valuedc/lin/prog/c++/Eigen/build/blas/testing && /usr/bin/gfortran  $(Fortran_DEFINES) $(Fortran_FLAGS) -c /media/valuedc/lin/prog/c++/Eigen/blas/testing/dblat2.f -o CMakeFiles/dblat2.dir/dblat2.f.o

blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.requires:
.PHONY : blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.requires

blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.provides: blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.requires
	$(MAKE) -f blas/testing/CMakeFiles/dblat2.dir/build.make blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.provides.build
.PHONY : blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.provides

blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.provides.build: blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o

# Object files for target dblat2
dblat2_OBJECTS = \
"CMakeFiles/dblat2.dir/dblat2.f.o"

# External object files for target dblat2
dblat2_EXTERNAL_OBJECTS =

blas/testing/dblat2: blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o
blas/testing/dblat2: blas/testing/CMakeFiles/dblat2.dir/build.make
blas/testing/dblat2: blas/libeigen_blas.so
blas/testing/dblat2: blas/testing/CMakeFiles/dblat2.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking Fortran executable dblat2"
	cd /media/valuedc/lin/prog/c++/Eigen/build/blas/testing && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/dblat2.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
blas/testing/CMakeFiles/dblat2.dir/build: blas/testing/dblat2
.PHONY : blas/testing/CMakeFiles/dblat2.dir/build

blas/testing/CMakeFiles/dblat2.dir/requires: blas/testing/CMakeFiles/dblat2.dir/dblat2.f.o.requires
.PHONY : blas/testing/CMakeFiles/dblat2.dir/requires

blas/testing/CMakeFiles/dblat2.dir/clean:
	cd /media/valuedc/lin/prog/c++/Eigen/build/blas/testing && $(CMAKE_COMMAND) -P CMakeFiles/dblat2.dir/cmake_clean.cmake
.PHONY : blas/testing/CMakeFiles/dblat2.dir/clean

blas/testing/CMakeFiles/dblat2.dir/depend:
	cd /media/valuedc/lin/prog/c++/Eigen/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/valuedc/lin/prog/c++/Eigen /media/valuedc/lin/prog/c++/Eigen/blas/testing /media/valuedc/lin/prog/c++/Eigen/build /media/valuedc/lin/prog/c++/Eigen/build/blas/testing /media/valuedc/lin/prog/c++/Eigen/build/blas/testing/CMakeFiles/dblat2.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : blas/testing/CMakeFiles/dblat2.dir/depend
