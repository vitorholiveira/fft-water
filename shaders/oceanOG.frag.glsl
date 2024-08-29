#version 430 core

// Outputs colors in RGBA
layout(location=0) out vec4 FragColor;

in struct data
{
    vec3 position; // vertex position in world space
    vec3 normal;   // normal position in world space
    vec3 color;    // vertex color
    vec2 uv;       // vertex uv
} fragment;

// Gets the Texture Units from the main function
uniform sampler2D diffuse0;
uniform sampler2D specular0;
// Gets the color of the light from the main function
uniform vec4 lightColor;
// Gets the position of the light from the main function
uniform vec3 lightPos;
// Gets the position of the camera from the main function
uniform vec3 camPos;

// Coefficients of phong illumination model
struct phong_structure {
    float ambient;      
    float diffuse;
    float specular;
    float specular_exponent;
};

// Settings for texture display
struct texture_settings_structure {
    bool use_texture;       // Switch the use of texture on/off
    bool texture_inverse_v; // Reverse the texture in the v component (1-v)
    bool two_sided;         // Display a two-sided illuminated surface (doesn't work on Mac)
};

// Material of the mesh (using a Phong model)
struct material_structure
{
    vec3 color;  // Uniform color of the object
    float alpha; // alpha coefficient

    phong_structure phong;                       // Phong coefficients
    texture_settings_structure texture_settings; // Additional settings for the texture
};

material_structure material;

in float dy;

uniform sampler2D image_texture;   // Texture image identifiant

uniform vec3 light; // position of the light

// Function to compute a simple subsurface scattering effect
vec3 computeSSS(vec3 color, vec3 normal, vec3 lightDir) {
    // Corrigir para considerar a luz entrando na superfície
    float scattering = max(dot(normal, -lightDir), 0.0);
    vec3 scatteredColor = color * scattering * vec3(110.0, 220.0, 250.0) / 256.0; // cor azul de dispersão subsuperficial
    return scatteredColor;
}

void main()
{
    material.color = vec3(1.0,1.0,1.0);
    material.alpha = 1.0;
    material.phong.ambient = 0.3;
    material.phong.diffuse = 0.6;
    material.phong.specular = 0.3;
    material.phong.specular_exponent = 64.0;
    material.texture_settings.use_texture = false;
    material.texture_settings.texture_inverse_v = false;
    material.texture_settings.two_sided = false;

    // Renormalize normal
    vec3 N = normalize(fragment.normal);

    // Inverse the normal if it is viewed from its back (two-sided surface)
    //  (note: gl_FrontFacing doesn't work on Mac)
    if (material.texture_settings.two_sided && gl_FrontFacing == false) {
        N = -N;
    }

    // Phong coefficient (diffuse, specular)
    // *************************************** //

    // Unit direction toward the light
    vec3 L = normalize(light-fragment.position);

    // Diffuse coefficient
    float diffuse_component = max(dot(N,L),0.0);

    // Specular coefficient
    float specular_component = 0.0;
    if(diffuse_component > 0.0){
        vec3 R = reflect(-L,N); // reflection of light vector relative to the normal.
        vec3 V = normalize(camPos-fragment.position);
        specular_component = pow( max(dot(R,V),0.0), material.phong.specular_exponent );
    }

    // Texture
    // *************************************** //

    // Current uv coordinates
    vec2 uv_image = vec2(fragment.uv.x, fragment.uv.y);
    if(material.texture_settings.texture_inverse_v) {
        uv_image.y = 1.0 - uv_image.y;
    }

    // Get the current texture color
    vec4 color_image_texture = texture(image_texture, uv_image);
    if(material.texture_settings.use_texture == false) {
        color_image_texture = vec4(1.0,1.0,1.0,1.0);
    }
    
    // Compute Shading
    // *************************************** //
    
    // Compute the base color of the object based on: vertex color, uniform color, and texture
    vec3 color_object  = fragment.color * material.color * color_image_texture.rgb;

    // Change color object according to height displacement
    vec3 inner_color = vec3(50.0, 150.0, 180.0) / 256.0;
    vec3 outter_color = vec3(1);
    color_object *= mix(inner_color, outter_color, dy/3.0);

    // Subsurface scattering effect
    vec3 sssColor = computeSSS(color_object, N, L);

    // Compute the final shaded color using Phong model with SSS
    float Ka = material.phong.ambient * 2.5f;
    float Kd = material.phong.diffuse * 0.3f;
    float Ks = material.phong.specular;
    vec3 color_shading = (Ka + Kd * diffuse_component) * color_object + Ks * specular_component * vec3(1.0, 1.0, 1.0);

    // Output color, with the alpha component
    FragColor = vec4(color_shading, material.alpha * color_image_texture.a );
}
