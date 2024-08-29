#version 330 core

uniform vec3 camPos; // Posição da câmera

// SOL
uniform vec3 _SunPosition = vec3(0.0, 1.0, -1.0) * 100.0;
uniform vec3 _SunColor = vec3(6.0, 3.4, 1.6); // Laranja avermelhado saturado
uniform float _SunIrradiance = 1.5;

// AMBIENTE
uniform vec3 _Ambient = vec3(15.0, 94.0, 156.0) / 256.0; // Mais azul para um tom de água mais frio
uniform vec3 _DiffuseReflectance = vec3(0.2, 0.2, 0.25)*2;

// SPECULAR
uniform vec3 _SpecularReflectance = vec3(0.4, 0.4, 0.5); // Aumenta a intensidade especular
uniform float _Shininess = 1.0; // Suaviza os reflexos especulares

// FRESNEL
uniform float _FresnelBias = 0.01;  // Reduzido para acentuar o efeito Fresnel em ângulos rasos
uniform float _FresnelStrength = 0.5; // Aumentado para intensificar o efeito
uniform float _FresnelShininess = 1.0; // Ajustado para suavizar o gradiente
uniform vec3 _FresnelColor = vec3(28.0, 163.0, 236.0) / 256.0; // Cor do Fresnel


// Parâmetros para subsurface scattering
uniform float _NormalDepthAttenuation = 1;
uniform vec3 _ScatterColor = vec3(90.0, 200.0, 216.0) / 255.0; // Azul esverdeado
uniform float _WavePeakScatterStrength = 210; // Aumentado para intensificar a dispersão nas cristas das ondas
uniform float _ScatterStrength = 3; // Aumentado para simular a dispersão sob a superfície
uniform float _ScatterShadowStrength = .1; // Suavizado para uma sombra mais natural

in struct data {
    vec3 position;
    vec3 normal;
    vec3 color;
    vec2 uv;
} fragment;

out vec4 FragColor;

float DotClamped(vec3 a, vec3 b) {
    return max(dot(a, b), 0.0);
}

vec3 HDR(vec3 color, float exposure) {
    return 1.0 - exp(-color * exposure);
}

void main() {
    // Direções de luz e visão
    vec3 lightDir = normalize(vec3(1.0,0.3,1.0));
    vec3 viewDir = normalize(camPos - fragment.position);
    vec3 halfwayDir = normalize(lightDir + viewDir);

    vec3 normalVec = normalize(fragment.normal);
    // Componentes de iluminação base
    float ndotl = DotClamped(normalVec, lightDir);
    float ndoth = DotClamped(normalVec, halfwayDir);

    // Cálculo de Fresnel
    float base = 1.0 - DotClamped(normalVec, viewDir);
    float fresnelFactor = _FresnelBias + pow(base, _FresnelShininess) * (1.0 - _FresnelBias);
    fresnelFactor *= _FresnelStrength;
    vec3 fresnel = _FresnelColor * fresnelFactor;

    // Reflexão difusa e especular
    vec3 diffuse = _SunColor * ndotl * (_DiffuseReflectance / 3.14159265359);
    vec3 specular = _SunColor * _SpecularReflectance * pow(ndoth, _Shininess); // blinn-phong

    // Subsurface Scattering
    vec3 macroNormal = vec3(0.0, 1.0, 0.0);
    vec3 mesoNormal = normalize(vec3(-normalVec.x, 1.0, -normalVec.z));
    mesoNormal = normalize(mix(vec3(0.0, 1.0, 0.0), mesoNormal, pow(clamp(fragment.position.y, 0.0, 1.0), _NormalDepthAttenuation)));
    
    // Parâmetros para SSS
    float H = max(0.0, fragment.position.y + 2);
    // scattering from weight height
    float k1 = _WavePeakScatterStrength * H * pow(DotClamped(lightDir, viewDir), 4.0) * pow(0.5 - 0.5 * dot(lightDir, mesoNormal), 3.0);
    // how strong the light reflected towards the eye is
    float k2 = _ScatterStrength * pow(DotClamped(viewDir, mesoNormal), 2.0);
    // lamberts cossine law
    float k3 = _ScatterShadowStrength * ndotl;
    // Cálculo da dispersão
    vec3 scatter = (k1 + k2) * _ScatterColor * _SunIrradiance * (1/_SunColor);
    scatter += k3 * _ScatterColor * _SunIrradiance;

    float F = 0.5f;
    // Combina os componentes de iluminação
    vec3 finalColor = fresnel + scatter + specular + _Ambient; 

    // Aplicação de HDR
    finalColor = HDR(finalColor, 0.35);

    FragColor = vec4(finalColor, 1.0);
}
