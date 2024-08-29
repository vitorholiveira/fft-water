#ifndef TEXTURE_CLASS_H
#define TEXTURE_CLASS_H

#include<glad/glad.h>
#include<stb/stb_image.h>

#include"shaderClass.h"

class Texture
{
public:
	GLuint ID;
	const char* type;
	GLuint unit = 0;
	int height;
	int width;

	Texture();

	Texture(const GLvoid *data);

	Texture(const char* image, const char* texType, GLuint slot, GLenum format, GLenum pixelType);

	// load a texture on GPU
	void load(const GLvoid *data);

	// Assigns a texture unit to a texture
	void texUnit(Shader& shader, const char* uniform, GLuint unit);
	// Binds a texture
	void Bind();
	// Unbinds a texture
	void Unbind();
	// Deletes a texture
	void Delete();
};
#endif