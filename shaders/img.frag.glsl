#version 430 core

// Entrada do fragment shader
in vec3 fragColor;
in vec2 fragTexUV;

// Saída do fragment shader
out vec4 FragColor;

uniform int mode;
uniform int u_resolution;  // Resolução da imagem quadrada (256x256)
uniform sampler2D texture1;

vec2 fftshift(vec2 texCoord) {
    vec2 shiftedCoord;
    shiftedCoord.x = mod(texCoord.x + 0.5, 1.0);
    shiftedCoord.y = mod(texCoord.y + 0.5, 1.0);
    return shiftedCoord;
}

void main()
{
    // Aplicar fftshift nas coordenadas de textura
    vec2 shiftedTexCoord = fftshift(fragTexUV);
    
    // Obter o valor complexo da textura
    vec2 complexValue = texture(texture1, shiftedTexCoord).rg;
    
    if (mode == 0) {
        // Calcular e visualizar a magnitude
        float magnitude = length(complexValue);
        // Aplicar log para melhorar a visualização
        magnitude = log(1.0 + magnitude);
        // Normalizar para o intervalo [0, 1]
        magnitude = magnitude / log(float(u_resolution));
        FragColor = vec4(magnitude, magnitude, magnitude, 1.0);
    } 
    else if (mode == 1) {
        // Calcular e visualizar a fase
        float phase = atan(complexValue.y, complexValue.x);
        // Normalizar a fase para o intervalo [0, 1]
        phase = (phase + 3.14159265359) / (2.0 * 3.14159265359);
        FragColor = vec4(vec3(phase), 1.0);
    } 
    else {
        // Fallback: renderizar o valor real como uma cor
        FragColor = vec4(texture(texture1, shiftedTexCoord).rgb, 1.0) * vec4(fragColor, 1.0);
    }
}