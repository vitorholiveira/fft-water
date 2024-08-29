#include "Mesh.h"

Mesh::Mesh(std::vector <Vertex>& vertices, std::vector <GLuint>& indices)
{
	Mesh::vertices = vertices;
	Mesh::indices = indices;

	vao.Bind();
	// Generates Vertex Buffer Object and links it to vertices
	VBO vbo(vertices);
	// Generates Element Buffer Object and links it to indices
	EBO ebo(indices);
	// Links VBO attributes such as coordinates and colors to VAO
	vao.LinkAttrib(vbo, 0, 3, GL_FLOAT, sizeof(Vertex), (void*)0);
	vao.LinkAttrib(vbo, 1, 3, GL_FLOAT, sizeof(Vertex), (void*)(3 * sizeof(float)));
	vao.LinkAttrib(vbo, 2, 3, GL_FLOAT, sizeof(Vertex), (void*)(6 * sizeof(float)));
	vao.LinkAttrib(vbo, 3, 2, GL_FLOAT, sizeof(Vertex), (void*)(9 * sizeof(float)));
	// Unbind all to prevent accidentally modifying them
	vao.Unbind();
	vbo.Unbind();
	ebo.Unbind();
}


void Mesh::Draw(Shader& shader, Camera& camera)
{
	// Bind shader to be able to access uniforms
	shader.Activate();
	vao.Bind();

	glm::mat4 model = glm::mat4(1.0); // Ajuste a matriz de modelo conforme necessário
	glUniformMatrix4fv(glGetUniformLocation(shader.ID, "model"), 1, GL_FALSE, glm::value_ptr(model));

	// Configurar a matriz de normais (model sem escala)
	glm::mat4 modelNormal = glm::transpose(glm::inverse(model));
	glUniformMatrix4fv(glGetUniformLocation(shader.ID, "modelNormal"), 1, GL_FALSE, glm::value_ptr(modelNormal));

	// NORMALS AND DISPLACEMENT_MAP
	int textureCount = 0;
 	for (auto& element : textures)
 	{
 		std::string textureName = element.first;
 		Texture texture = element.second;

 	 	texture.texUnit(shader, textureName.c_str(), textureCount);
 	 	texture.Bind();
		//std::cout << 'oi'

 	 	textureCount++;
 	}

	int resolution = 256; // Ajuste conforme necessário
    glUniform1i(glGetUniformLocation(shader.ID, "u_resolution"), resolution);

	// Take care of the camera Matrix
	glUniform3f(glGetUniformLocation(shader.ID, "camPos"), camera.Position.x, camera.Position.y, camera.Position.z);
	camera.Matrix(shader, "cameraMatrix");

	// Draw the actual mesh
	glDrawElements(GL_TRIANGLES, indices.size(), GL_UNSIGNED_INT, 0);
}

// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA MESH
// void Mesh::Draw(Shader& shader, Camera& camera)
// {
// 	// Bind shader to be able to access uniforms
// 	shader.Activate();
// 	vao.Bind();

// 	// Configurar a matriz de modelo
//     glm::mat4 model = glm::mat4(1.0); // Ajuste a matriz de modelo conforme necessário
//     glUniformMatrix4fv(glGetUniformLocation(shader.ID, "model"), 1, GL_FALSE, glm::value_ptr(model));

//     // Configurar a matriz de normais (model sem escala)
//     //glm::mat4 modelNormal = glm::transpose(glm::inverse(model));
//     //glUniformMatrix4fv(glGetUniformLocation(shader.ID, "modelNormal"), 1, GL_FALSE, glm::value_ptr(modelNormal));

// 	// Configurar a matriz de câmera
//     camera.Matrix(shader, "view");
//     glm::mat4 projection = camera.projectionMatrix; // Assumindo que a câmera tem um método para isso
//     glUniformMatrix4fv(glGetUniformLocation(shader.ID, "projection"), 1, GL_FALSE, glm::value_ptr(camera.projectionMatrix));

// 	// light
// 	//glUniform3f(glGetUniformLocation(shader.ID, "light"),1.0f,1.0f,1.0f);

// 	// int textureCount = 1;
// 	// for (auto& element : supplementaryTextures)
// 	// {
// 	// 	std::string textureName = element.first;
// 	// 	Texture texture = element.second;

// 	// 	glActiveTexture(GL_TEXTURE0 + textureCount);
// 	// 	texture.texUnit(shader, textureName.c_str(), textureCount);
// 	// 	texture.Bind();

// 	// 	textureCount++;
// 	// }

// 	//int resolution = 256; // Ajuste conforme necessário
//     //glUniform1i(glGetUniformLocation(shader.ID, "u_resolution"), resolution);

// 	// Draw the actual mesh
// 	glDrawElements(GL_TRIANGLES, indices.size(), GL_UNSIGNED_INT, 0);
// }