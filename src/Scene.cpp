#include"Scene.h"
#include<random>

#define RESOLUTION 256 // must be 2^k
#define WORK_GROUP_DIM 16 // NE PAS CHANGER !!

const int ocean_size = 256;
const int amplitude = 40;
const float scale = 0.05;
const float ocean_length = scale*ocean_size;
const float ocean_height = 0.0;

// parametros espectro
const float wind_magnitude = 100.0f;
const float wind_angle = 45.0f;
const float choppiness = 0.5f; // mudar

// funcition inspired by "mesh_primitive_grid" from CGP library
// https://graphicscomputing.fr/cgp/documentation/01_general/index.html
std::unique_ptr<Mesh> createMeshGrid(glm::vec3& p00, glm::vec3& p10, glm::vec3& p11, glm::vec3& p01, int Nu, int Nv)
{
    // Verificação dos parâmetros
    assert(Nu > 1 && Nv > 1 && "Grid sample must be > 1");

    std::vector<Vertex> vertices;
    std::vector<GLuint> indices;

    // Criação dos vértices
    for (int ku = 0; ku < Nu; ++ku) {
        for (int kv = 0; kv < Nv; ++kv) {
            float u = static_cast<float>(ku) / (Nu - 1);
            float v = static_cast<float>(kv) / (Nv - 1);

            // Interpolação bilinear para a posição
            glm::vec3 position = (1 - u) * (1 - v) * p00 + u * (1 - v) * p10 + u * v * p11 + (1 - u) * v * p01;

            // Cálculo das normais
            glm::vec3 dpdu = (1 - u) * (-p00 + p01) + u * (-p10 + p11);
            glm::vec3 dpdv = (1 - v) * (-p00 + p10) + v * (p11 - p01);
            glm::vec3 normal = glm::normalize(glm::cross(dpdv, dpdu));

            // Coordenadas de textura
            glm::vec2 texUV = glm::vec2(u, v);

            // Adicionando o vértice
            Vertex vertex;
            vertex.position = position;
            vertex.normal = normal;
            vertex.texUV = texUV;
            vertex.color = glm::vec3(1.0f); // A cor pode ser definida de acordo com suas necessidades

            vertices.push_back(vertex);
        }
    }

    // Criação dos índices para conectividade dos triângulos
    for (int ku = 0; ku < Nu - 1; ++ku) {
        for (int kv = 0; kv < Nv - 1; ++kv) {
            // Definindo os vértices de cada quadrado
            int topLeft = ku * Nv + kv;
            int topRight = topLeft + 1;
            int bottomLeft = (ku + 1) * Nv + kv;
            int bottomRight = bottomLeft + 1;

            // Triângulo 1
            indices.push_back(topLeft);
            indices.push_back(bottomLeft);
            indices.push_back(topRight);

            // Triângulo 2
            indices.push_back(topRight);
            indices.push_back(bottomLeft);
            indices.push_back(bottomRight);
        }
    }

    return std::make_unique<Mesh>(vertices, indices);
}

std::unique_ptr<Mesh> createMeshQuad(glm::vec3& p00, glm::vec3& p10, glm::vec3& p11, glm::vec3& p01) {
    // Definir a cor padrão (pode ser ajustada conforme necessário)
    glm::vec3 defaultColor(1.0f, 1.0f, 1.0f);  // Branco

    // Calcular a normal do plano (assumindo que o quadrado é planar)
    glm::vec3 normal = glm::normalize(glm::cross(p10 - p00, p01 - p00));

    // Definir os vértices
    std::vector<Vertex> vertices = {
        { p00, normal, defaultColor, glm::vec2(0.0f, 0.0f) }, // Inferior esquerdo
        { p10, normal, defaultColor, glm::vec2(1.0f, 0.0f) }, // Inferior direito
        { p11, normal, defaultColor, glm::vec2(1.0f, 1.0f) }, // Superior direito
        { p01, normal, defaultColor, glm::vec2(0.0f, 1.0f) }  // Superior esquerdo
    };

    // Definir os índices para desenhar os dois triângulos do quadrado
    std::vector<GLuint> indices = {
        0, 1, 2, // Primeiro triângulo
        2, 3, 0  // Segundo triângulo
    };

    // Criar e retornar o Mesh
    return std::make_unique<Mesh>(vertices, indices);
}

Scene::Scene(GLFWwindow* window)
{
    Scene::window = window;

    waterShader = std::make_unique<Shader>("../../shaders/ocean.vert.glsl", "../../shaders/ocean.frag.glsl");

    spectrum0 = std::make_unique<Shader>("../../shaders/compute_shaders/spectrum_0.comp.glsl");
    spectrum = std::make_unique<Shader>("../../shaders/compute_shaders/spectrum_t.comp.glsl");
    ifftHorizontal = std::make_unique<Shader>("../../shaders/compute_shaders/ifft_columns.comp.glsl");
    ifftVertical = std::make_unique<Shader>("../../shaders/compute_shaders/ifft_rows.comp.glsl");
    normal = std::make_unique<Shader>("../../shaders/compute_shaders/normal.comp.glsl");
    imgShader = std::make_unique<Shader>("../../shaders/img.vert.glsl", "../../shaders/img.frag.glsl");

    float tileSize = 60.0f;
	//Mesh floor(verts, ind, tex);
	glm::vec3 p00 = glm::vec3(0.0f,-2.0f,0.0f);
	glm::vec3 p01 = glm::vec3(0.0f,-2.0f,ocean_length);
	glm::vec3 p10 = glm::vec3(ocean_length,-2.0f,0.0f);
	glm::vec3 p11 = glm::vec3(ocean_length,-2.0f,ocean_length);
	water = createMeshGrid(p00, p10, p11, p01, RESOLUTION, RESOLUTION);

    float dx = (ocean_length - 1.0f)/2;

    // IMAGEM ESPECTRO DE MAGNITUDE
    glm::vec3 quadP00 = glm::vec3(dx, -0.5f, 0.0f); // Inferior esquerdo
    glm::vec3 quadP01 = glm::vec3(1.0f+dx, -0.5f, 0.0f); // Inferior direito
    glm::vec3 quadP10 = glm::vec3(dx,  0.5f, 0.0f); // Superior esquerdo
    glm::vec3 quadP11 = glm::vec3(1.0f+dx,  0.5f, 0.0f); // Superior direito
    spectrumMagQuad = createMeshQuad(quadP00, quadP10, quadP11, quadP01);
    spectrumMagQuad->textures["texture1"] = dyImg;

    // IMAGEM ESPECTRO DE FASE  
    quadP00.y += 1.5f; quadP01.y += 1.5f; quadP10.y += 1.5f; quadP11.y += 1.5f;
    spectrumPhaseQuad = createMeshQuad(quadP00, quadP10, quadP11, quadP01);
    spectrumPhaseQuad->textures["texture1"] = dyImg;

    // IMAGEM NORMAIS
    quadP00.y -= 1.5f; quadP01.y -= 1.5f; quadP10.y -= 1.5f; quadP11.y -= 1.5f;
    quadP00.x -= 1.5f; quadP01.x -= 1.5f; quadP10.x -= 1.5f; quadP11.x -= 1.5f;
    normalsQuad = createMeshQuad(quadP00, quadP10, quadP11, quadP01);
    normalsQuad->textures["texture1"] = normalsImg;
    

    // IMAGEM DESLOCAMENTOS
    quadP00.x += 3.0f; quadP01.x += 3.0f; quadP10.x += 3.0f; quadP11.x += 3.0f;
    displacementQuad = createMeshQuad(quadP00, quadP10, quadP11, quadP01);
    displacementQuad->textures["texture1"] = displacementImg;

    water->textures["u_displacement_map"] = displacementImg;
    water->textures["u_normal_map"] = normalsImg;

    camera = std::make_unique<Camera>(glm::vec3(ocean_length/2, 1.0f, 2*ocean_length));

    startTime = std::chrono::high_resolution_clock::now();
    initializeSpectrum();
}

void Scene::displayFrame()
{
    currentFrame = glfwGetTime();
    deltaTime = currentFrame - lastFrame;
    lastFrame = currentFrame;

    camera->Inputs(window, deltaTime);
    camera->updateMatrix(45.0f, 0.1f, 1000.0f, window);
    //std::cout << count << std::endl;
    if(count < 10)
        updateSpectrum();
    //count++;

    imgShader->Activate();
    glUniform1i(glGetUniformLocation(imgShader->ID, "mode"), 0);
    spectrumMagQuad->Draw(*imgShader, *camera);
    glUniform1i(glGetUniformLocation(imgShader->ID, "mode"), 1);
    spectrumPhaseQuad->Draw(*imgShader, *camera);

    ifft(*ifftVertical, dyImg);
    ifft(*ifftHorizontal, dyImg);
    ifft(*ifftHorizontal, dxImg);
    ifft(*ifftVertical, dxImg);
    ifft(*ifftHorizontal, dzImg);
    ifft(*ifftVertical, dzImg);
    if(count < 10)
        updateNormals();

    glUniform1i(glGetUniformLocation(imgShader->ID, "mode"), 2);
    water->Draw(*waterShader, *camera);
    imgShader->Activate();
    glUniform1i(glGetUniformLocation(imgShader->ID, "mode"), 2);
    normalsQuad->Draw(*imgShader, *camera);
    glUniform1i(glGetUniformLocation(imgShader->ID, "mode"), 2);
    displacementQuad->Draw(*imgShader, *camera);
}

void Scene::destroy()
{
    waterShader->Delete();
}

void Scene::initializeSpectrum()
{
	spectrum0->Activate();
	int u_resolution = RESOLUTION;
	int u_ocean_size = ocean_size; 
	float u_amplitude = amplitude;

	float wind_angle_rad =  M_PI*wind_angle/180.f;
	glm::vec2 u_wind = glm::vec2(wind_magnitude * cos(wind_angle_rad), wind_magnitude * sin(wind_angle_rad));

    glUniform1i(glGetUniformLocation(spectrum0->ID, "u_resolution"), u_resolution);
    glUniform1i(glGetUniformLocation(spectrum0->ID, "u_ocean_size"), u_ocean_size);
    glUniform1f(glGetUniformLocation(spectrum0->ID, "u_amplitude"), u_amplitude);
    glUniform2f(glGetUniformLocation(spectrum0->ID, "u_wind"), u_wind.x, u_wind.y);

	std::vector<float> gaussianRnd(4* RESOLUTION * RESOLUTION);
	std::random_device dev;
	std::mt19937 rng(dev());
	std::normal_distribution<float> dist(0.f, 1.f); //~N(0,1)
	for (int i = 0; i < (int) gaussianRnd.size(); ++i)
		gaussianRnd[i] = dist(rng);

    Texture gaussianNoise(gaussianRnd.data());

	glBindImageTexture(0, spectrum0Img.ID, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);
	glBindImageTexture(1, gaussianNoise.ID, 0, GL_FALSE, 0, GL_READ_ONLY, GL_RGBA32F);

	glDispatchCompute(RESOLUTION / WORK_GROUP_DIM, RESOLUTION / WORK_GROUP_DIM, 1);
	glFinish();
    spectrum0->Deactivate();
}

void Scene::updateSpectrum()
{
    spectrum->Activate();
	int u_resolution = RESOLUTION;
	int u_ocean_size = ocean_size; 
	float u_choppiness = choppiness;

    auto currentTime = std::chrono::high_resolution_clock::now();
    std::chrono::duration<float> elapsed = currentTime - startTime;
    float u_time = elapsed.count();

    glUniform1i(glGetUniformLocation(spectrum->ID, "u_resolution"), u_resolution);
    glUniform1i(glGetUniformLocation(spectrum->ID, "u_ocean_size"), u_ocean_size);
    glUniform1f(glGetUniformLocation(spectrum->ID, "u_choppiness"), u_choppiness);
    glUniform1f(glGetUniformLocation(spectrum->ID, "u_time"), u_time);

    glBindImageTexture(0, spectrum0Img.ID, 0, GL_FALSE, 0, GL_READ_ONLY, GL_RGBA32F);
	glBindImageTexture(1, dyImg.ID, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);
	glBindImageTexture(2, dxImg.ID, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);
	glBindImageTexture(3, dzImg.ID, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);

	glDispatchCompute(RESOLUTION / WORK_GROUP_DIM, RESOLUTION / WORK_GROUP_DIM, 1);
	glFinish();

    spectrum->Deactivate();
}

void Scene::ifft(Shader &shader, Texture &texture)
{
	shader.Activate();
	int u_resolution = RESOLUTION; 
    glUniform1i(glGetUniformLocation(shader.ID, "u_resolution"), u_resolution);
	
	auto& tmp = tempImg;

	bool swap_temp = false;
	for (int stride = 1, count = RESOLUTION; count >= 1; stride <<= 1, count >>= 1)
	{
		glBindImageTexture(0, texture.ID, 0, GL_FALSE, 0, GL_READ_ONLY, GL_RGBA32F);
		glBindImageTexture(1, tmp.ID, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);

        glUniform1i(glGetUniformLocation(shader.ID, "u_stride"), stride);
        glUniform1i(glGetUniformLocation(shader.ID, "u_count"), count);

		// two calculations per shader execution
		glDispatchCompute(RESOLUTION, RESOLUTION / 2, 1);
		glMemoryBarrier(GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
	
		std::swap(tmp, texture);
		swap_temp = !swap_temp;
	}
	if(swap_temp) std::swap(tmp, texture);
    shader.Deactivate();
}

void Scene::updateNormals()
{
    normal->Activate();

	glBindImageTexture(0, dyImg.ID, 0, GL_FALSE, 0, GL_READ_ONLY, GL_RGBA32F);
	glBindImageTexture(1, dxImg.ID, 0, GL_FALSE, 0, GL_READ_ONLY, GL_RGBA32F);
	glBindImageTexture(2, dzImg.ID, 0, GL_FALSE, 0, GL_READ_ONLY, GL_RGBA32F);
	glBindImageTexture(3, normalsImg.ID, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);
	glBindImageTexture(4, displacementImg.ID, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);

	glDispatchCompute(RESOLUTION / WORK_GROUP_DIM, RESOLUTION / WORK_GROUP_DIM, 1);
	glFinish();
    normal->Deactivate();
}