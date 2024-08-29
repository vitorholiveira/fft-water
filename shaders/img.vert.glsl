#version 430 core

// Entrada de atributos
layout (location = 0) in vec3 vertex_position; // vertex position in local space (x,y,z)
layout (location = 1) in vec3 vertex_normal;   // vertex normal in local space   (nx,ny,nz)
layout (location = 2) in vec3 vertex_color;    // vertex color      (r,g,b)
layout (location = 3) in vec2 vertex_uv;       // vertex uv-texture (u,v)

// Saídas para o fragment shader
out vec3 fragColor;
out vec2 fragTexUV;

uniform mat4 cameraMatrix;

void main()
{
    // Passar a cor e as coordenadas de textura para o fragment shader
    fragColor = vertex_color;
    fragTexUV = vertex_uv;

    // Calcular a posição final do vértice
    gl_Position = cameraMatrix * vec4(vertex_position, 1.0);
}
