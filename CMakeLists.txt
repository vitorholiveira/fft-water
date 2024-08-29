cmake_minimum_required(VERSION 3.10)
project(main_project)

# Definir o padrão C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Diretórios
set(SRCDIR src)
set(INCDIR include)
set(BINDIR bin/${CMAKE_SYSTEM_NAME})  # Define diretório de saída com base no sistema
set(LIBDIR lib-${CMAKE_SYSTEM_NAME})  # Define o diretório de bibliotecas com base no sistema

# Adiciona o diretório de include
include_directories(${INCDIR})

# Adiciona os arquivos de origem
file(GLOB SRCS "${SRCDIR}/*.cpp" "${SRCDIR}/glad.c")

# Cria o executável
add_executable(main ${SRCS})

# Define o diretório de saída do executável
set_target_properties(main PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${BINDIR}
)

# Especifica as bibliotecas com base no sistema operacional
if(WIN32)
    link_directories(${LIBDIR})  # Adiciona o diretório das bibliotecas no Windows
    target_link_libraries(main
        glfw3  # Não incluir o prefixo 'lib' e a extensão '.lib'
        opengl32
    )
elseif(APPLE)
    find_library(COCOA_LIBRARY Cocoa REQUIRED)
    find_library(IOKIT_LIBRARY IOKit REQUIRED)
    find_library(COREVIDEO_LIBRARY CoreVideo REQUIRED)
    
    target_link_libraries(main
        ${LIBDIR}/libglfw3.a
        ${COCOA_LIBRARY}
        ${IOKIT_LIBRARY}
        ${COREVIDEO_LIBRARY}
        "-framework OpenGL"
    )
else()  # Linux
    link_directories(${LIBDIR})  # Adiciona o diretório das bibliotecas no Linux
    target_link_libraries(main
        glfw3  # O nome da biblioteca sem o prefixo 'lib' e a extensão '.a'
        rt
        m
        dl
        X11
        pthread
        Xrandr
        Xinerama
        Xxf86vm
        Xcursor
    )
endif()
