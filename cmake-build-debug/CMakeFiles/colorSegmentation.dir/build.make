# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.12

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


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
CMAKE_COMMAND = /opt/clion-2018.2/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /opt/clion-2018.2/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/osboxes/Projects/tissueRetraction

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/osboxes/Projects/tissueRetraction/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/colorSegmentation.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/colorSegmentation.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/colorSegmentation.dir/flags.make

CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.o: CMakeFiles/colorSegmentation.dir/flags.make
CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.o: ../colorSegmentation.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/osboxes/Projects/tissueRetraction/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.o -c /home/osboxes/Projects/tissueRetraction/colorSegmentation.cpp

CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/osboxes/Projects/tissueRetraction/colorSegmentation.cpp > CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.i

CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/osboxes/Projects/tissueRetraction/colorSegmentation.cpp -o CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.s

CMakeFiles/colorSegmentation.dir/ShowImages.cpp.o: CMakeFiles/colorSegmentation.dir/flags.make
CMakeFiles/colorSegmentation.dir/ShowImages.cpp.o: ../ShowImages.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/osboxes/Projects/tissueRetraction/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/colorSegmentation.dir/ShowImages.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/colorSegmentation.dir/ShowImages.cpp.o -c /home/osboxes/Projects/tissueRetraction/ShowImages.cpp

CMakeFiles/colorSegmentation.dir/ShowImages.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/colorSegmentation.dir/ShowImages.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/osboxes/Projects/tissueRetraction/ShowImages.cpp > CMakeFiles/colorSegmentation.dir/ShowImages.cpp.i

CMakeFiles/colorSegmentation.dir/ShowImages.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/colorSegmentation.dir/ShowImages.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/osboxes/Projects/tissueRetraction/ShowImages.cpp -o CMakeFiles/colorSegmentation.dir/ShowImages.cpp.s

CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.o: CMakeFiles/colorSegmentation.dir/flags.make
CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.o: ../ImageProcessing.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/osboxes/Projects/tissueRetraction/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.o -c /home/osboxes/Projects/tissueRetraction/ImageProcessing.cpp

CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/osboxes/Projects/tissueRetraction/ImageProcessing.cpp > CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.i

CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/osboxes/Projects/tissueRetraction/ImageProcessing.cpp -o CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.s

# Object files for target colorSegmentation
colorSegmentation_OBJECTS = \
"CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.o" \
"CMakeFiles/colorSegmentation.dir/ShowImages.cpp.o" \
"CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.o"

# External object files for target colorSegmentation
colorSegmentation_EXTERNAL_OBJECTS =

colorSegmentation: CMakeFiles/colorSegmentation.dir/colorSegmentation.cpp.o
colorSegmentation: CMakeFiles/colorSegmentation.dir/ShowImages.cpp.o
colorSegmentation: CMakeFiles/colorSegmentation.dir/ImageProcessing.cpp.o
colorSegmentation: CMakeFiles/colorSegmentation.dir/build.make
colorSegmentation: CMakeFiles/colorSegmentation.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/osboxes/Projects/tissueRetraction/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable colorSegmentation"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/colorSegmentation.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/colorSegmentation.dir/build: colorSegmentation

.PHONY : CMakeFiles/colorSegmentation.dir/build

CMakeFiles/colorSegmentation.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/colorSegmentation.dir/cmake_clean.cmake
.PHONY : CMakeFiles/colorSegmentation.dir/clean

CMakeFiles/colorSegmentation.dir/depend:
	cd /home/osboxes/Projects/tissueRetraction/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/osboxes/Projects/tissueRetraction /home/osboxes/Projects/tissueRetraction /home/osboxes/Projects/tissueRetraction/cmake-build-debug /home/osboxes/Projects/tissueRetraction/cmake-build-debug /home/osboxes/Projects/tissueRetraction/cmake-build-debug/CMakeFiles/colorSegmentation.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/colorSegmentation.dir/depend

