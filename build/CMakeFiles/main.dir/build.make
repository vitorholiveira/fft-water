# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/vitor/ufrgs_2024/fotografia/tf

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/vitor/ufrgs_2024/fotografia/tf/build

# Include any dependencies generated for this target.
include CMakeFiles/main.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/main.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/main.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/main.dir/flags.make

CMakeFiles/main.dir/src/EBO.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/src/EBO.cpp.o: ../src/EBO.cpp
CMakeFiles/main.dir/src/EBO.cpp.o: CMakeFiles/main.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/main.dir/src/EBO.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/main.dir/src/EBO.cpp.o -MF CMakeFiles/main.dir/src/EBO.cpp.o.d -o CMakeFiles/main.dir/src/EBO.cpp.o -c /home/vitor/ufrgs_2024/fotografia/tf/src/EBO.cpp

CMakeFiles/main.dir/src/EBO.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/src/EBO.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vitor/ufrgs_2024/fotografia/tf/src/EBO.cpp > CMakeFiles/main.dir/src/EBO.cpp.i

CMakeFiles/main.dir/src/EBO.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/src/EBO.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vitor/ufrgs_2024/fotografia/tf/src/EBO.cpp -o CMakeFiles/main.dir/src/EBO.cpp.s

CMakeFiles/main.dir/src/Ocean.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/src/Ocean.cpp.o: ../src/Ocean.cpp
CMakeFiles/main.dir/src/Ocean.cpp.o: CMakeFiles/main.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/main.dir/src/Ocean.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/main.dir/src/Ocean.cpp.o -MF CMakeFiles/main.dir/src/Ocean.cpp.o.d -o CMakeFiles/main.dir/src/Ocean.cpp.o -c /home/vitor/ufrgs_2024/fotografia/tf/src/Ocean.cpp

CMakeFiles/main.dir/src/Ocean.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/src/Ocean.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vitor/ufrgs_2024/fotografia/tf/src/Ocean.cpp > CMakeFiles/main.dir/src/Ocean.cpp.i

CMakeFiles/main.dir/src/Ocean.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/src/Ocean.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vitor/ufrgs_2024/fotografia/tf/src/Ocean.cpp -o CMakeFiles/main.dir/src/Ocean.cpp.s

CMakeFiles/main.dir/src/Shader.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/src/Shader.cpp.o: ../src/Shader.cpp
CMakeFiles/main.dir/src/Shader.cpp.o: CMakeFiles/main.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/main.dir/src/Shader.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/main.dir/src/Shader.cpp.o -MF CMakeFiles/main.dir/src/Shader.cpp.o.d -o CMakeFiles/main.dir/src/Shader.cpp.o -c /home/vitor/ufrgs_2024/fotografia/tf/src/Shader.cpp

CMakeFiles/main.dir/src/Shader.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/src/Shader.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vitor/ufrgs_2024/fotografia/tf/src/Shader.cpp > CMakeFiles/main.dir/src/Shader.cpp.i

CMakeFiles/main.dir/src/Shader.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/src/Shader.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vitor/ufrgs_2024/fotografia/tf/src/Shader.cpp -o CMakeFiles/main.dir/src/Shader.cpp.s

CMakeFiles/main.dir/src/VAO.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/src/VAO.cpp.o: ../src/VAO.cpp
CMakeFiles/main.dir/src/VAO.cpp.o: CMakeFiles/main.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/main.dir/src/VAO.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/main.dir/src/VAO.cpp.o -MF CMakeFiles/main.dir/src/VAO.cpp.o.d -o CMakeFiles/main.dir/src/VAO.cpp.o -c /home/vitor/ufrgs_2024/fotografia/tf/src/VAO.cpp

CMakeFiles/main.dir/src/VAO.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/src/VAO.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vitor/ufrgs_2024/fotografia/tf/src/VAO.cpp > CMakeFiles/main.dir/src/VAO.cpp.i

CMakeFiles/main.dir/src/VAO.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/src/VAO.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vitor/ufrgs_2024/fotografia/tf/src/VAO.cpp -o CMakeFiles/main.dir/src/VAO.cpp.s

CMakeFiles/main.dir/src/VBO.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/src/VBO.cpp.o: ../src/VBO.cpp
CMakeFiles/main.dir/src/VBO.cpp.o: CMakeFiles/main.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/main.dir/src/VBO.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/main.dir/src/VBO.cpp.o -MF CMakeFiles/main.dir/src/VBO.cpp.o.d -o CMakeFiles/main.dir/src/VBO.cpp.o -c /home/vitor/ufrgs_2024/fotografia/tf/src/VBO.cpp

CMakeFiles/main.dir/src/VBO.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/src/VBO.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vitor/ufrgs_2024/fotografia/tf/src/VBO.cpp > CMakeFiles/main.dir/src/VBO.cpp.i

CMakeFiles/main.dir/src/VBO.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/src/VBO.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vitor/ufrgs_2024/fotografia/tf/src/VBO.cpp -o CMakeFiles/main.dir/src/VBO.cpp.s

CMakeFiles/main.dir/src/glad.c.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/src/glad.c.o: ../src/glad.c
CMakeFiles/main.dir/src/glad.c.o: CMakeFiles/main.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/main.dir/src/glad.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/main.dir/src/glad.c.o -MF CMakeFiles/main.dir/src/glad.c.o.d -o CMakeFiles/main.dir/src/glad.c.o -c /home/vitor/ufrgs_2024/fotografia/tf/src/glad.c

CMakeFiles/main.dir/src/glad.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/main.dir/src/glad.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/vitor/ufrgs_2024/fotografia/tf/src/glad.c > CMakeFiles/main.dir/src/glad.c.i

CMakeFiles/main.dir/src/glad.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/main.dir/src/glad.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/vitor/ufrgs_2024/fotografia/tf/src/glad.c -o CMakeFiles/main.dir/src/glad.c.s

CMakeFiles/main.dir/src/main.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/src/main.cpp.o: ../src/main.cpp
CMakeFiles/main.dir/src/main.cpp.o: CMakeFiles/main.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/main.dir/src/main.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/main.dir/src/main.cpp.o -MF CMakeFiles/main.dir/src/main.cpp.o.d -o CMakeFiles/main.dir/src/main.cpp.o -c /home/vitor/ufrgs_2024/fotografia/tf/src/main.cpp

CMakeFiles/main.dir/src/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/src/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vitor/ufrgs_2024/fotografia/tf/src/main.cpp > CMakeFiles/main.dir/src/main.cpp.i

CMakeFiles/main.dir/src/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/src/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vitor/ufrgs_2024/fotografia/tf/src/main.cpp -o CMakeFiles/main.dir/src/main.cpp.s

# Object files for target main
main_OBJECTS = \
"CMakeFiles/main.dir/src/EBO.cpp.o" \
"CMakeFiles/main.dir/src/Ocean.cpp.o" \
"CMakeFiles/main.dir/src/Shader.cpp.o" \
"CMakeFiles/main.dir/src/VAO.cpp.o" \
"CMakeFiles/main.dir/src/VBO.cpp.o" \
"CMakeFiles/main.dir/src/glad.c.o" \
"CMakeFiles/main.dir/src/main.cpp.o"

# External object files for target main
main_EXTERNAL_OBJECTS =

bin/Linux/main: CMakeFiles/main.dir/src/EBO.cpp.o
bin/Linux/main: CMakeFiles/main.dir/src/Ocean.cpp.o
bin/Linux/main: CMakeFiles/main.dir/src/Shader.cpp.o
bin/Linux/main: CMakeFiles/main.dir/src/VAO.cpp.o
bin/Linux/main: CMakeFiles/main.dir/src/VBO.cpp.o
bin/Linux/main: CMakeFiles/main.dir/src/glad.c.o
bin/Linux/main: CMakeFiles/main.dir/src/main.cpp.o
bin/Linux/main: CMakeFiles/main.dir/build.make
bin/Linux/main: CMakeFiles/main.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Linking CXX executable bin/Linux/main"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/main.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/main.dir/build: bin/Linux/main
.PHONY : CMakeFiles/main.dir/build

CMakeFiles/main.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/main.dir/cmake_clean.cmake
.PHONY : CMakeFiles/main.dir/clean

CMakeFiles/main.dir/depend:
	cd /home/vitor/ufrgs_2024/fotografia/tf/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/vitor/ufrgs_2024/fotografia/tf /home/vitor/ufrgs_2024/fotografia/tf /home/vitor/ufrgs_2024/fotografia/tf/build /home/vitor/ufrgs_2024/fotografia/tf/build /home/vitor/ufrgs_2024/fotografia/tf/build/CMakeFiles/main.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/main.dir/depend

