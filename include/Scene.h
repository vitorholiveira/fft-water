#ifndef SCENE_CLASS_H
#define SCENE_CLASS_H

#include"Camera.h"
#include"Mesh.h"
#include <memory>
#include<chrono>
class Scene
{
public:
    Mesh oceanTile;
    GLFWwindow* window;
    float currentFrame, deltaTime, lastFrame;

    Texture spectrum0Img;
    Texture dxImg;
    Texture dyImg;
    Texture dzImg;
    Texture spectrumImg;
    Texture normalsImg;
    Texture displacementImg;

    // utility texture for ifft
    Texture tempImg;

    int count = 0;

    std::unique_ptr<Camera> camera;
    std::unique_ptr<Mesh> water;
    std::unique_ptr<Mesh> displacementQuad;
    std::unique_ptr<Mesh> normalsQuad;
    std::unique_ptr<Mesh> spectrumMagQuad;
    std::unique_ptr<Mesh> spectrumPhaseQuad;

    std::unique_ptr<Shader> waterShader;
    std::unique_ptr<Shader> imgShader;

    std::unique_ptr<Shader> spectrum0;
    std::unique_ptr<Shader> spectrum;
    std::unique_ptr<Shader> ifftHorizontal;
    std::unique_ptr<Shader> ifftVertical;
    std::unique_ptr<Shader> normal;

    std::chrono::time_point<std::chrono::high_resolution_clock> startTime;


    Scene(GLFWwindow* window);
    void displayFrame();
    void destroy();

    void initializeSpectrum();
    void updateSpectrum();
    void updateNormals();
    void ifft(Shader &shader, Texture &texture);

};
#endif