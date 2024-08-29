#ifndef MESH_CLASS_H
#define MESH_CLASS_H

#include<string>

#include"VAO.h"
#include"EBO.h"
#include"Camera.h"
#include"Texture.h"

#include<map>

class Mesh
{
public:
	std::vector <Vertex> vertices;
	std::vector <GLuint> indices;

	std::map<std::string, Texture> textures;
	// Store VAO in public so it can be used in the Draw function
	VAO vao;

	// Initializes the mesh
	Mesh(std::vector <Vertex>& vertices, std::vector <GLuint>& indices);
	Mesh() = default;

	// Draws the mesh
	void Draw(Shader& shader, Camera& camera);
};
#endif