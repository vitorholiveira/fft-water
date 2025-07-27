# FFT Water

This project is an implementation of an animated water mesh using the Fast Fourier Transform (FFT) in OpenGL. It was created as the final project for the Computational Photography class (2024/1) at the Federal University of Rio Grande do Sul (UFRGS). The core implementation is based on the concepts from [Jerry Tessendorf's paper on simulating ocean water](https://people.computing.clemson.edu/~jtessen/reports/papers_files/coursenotes2004.pdf).

![Water Mesh Demo](assets/water.gif)

## How to Run

This project is intended to be run in a Linux environment using the provided Makefile.

```bash
make run
```

## Technical Description
The simulation employs several key techniques to achieve a realistic water effect:

* **Spectral Functions**: The Phillips spectral function is used to model the distribution of wave energy across the ocean surface. It describes how energy is distributed as a function of the wave vector k.

* **Initial Spectrum Generation**: An initial spectrum is generated using the Phillips function combined with random Gaussian noise. This process is handled by a compute shader on the GPU.

* **Spectrum Evolution Over Time**: To animate the water surface, the wave spectrum is evolved over time. The height field h(k, t) is calculated based on the initial spectrum and its complex conjugate, modulated by the angular frequency of the waves. This is also implemented in a compute shader.

* **Normals in the Frequency Domain**: For realistic lighting, surface normals are calculated efficiently in the frequency domain using the partial derivatives of the height field. These normals are crucial for simulating light reflection and refraction.

* **Choppiness (Agitation)**: To simulate more turbulent seas, a "choppiness" effect is added. This displaces the vertices of the water mesh horizontally based on the wave's slope.

* **Fragment Shader for Lighting**: The fragment shader includes includes:

    * Blinn-Phong model for specular reflections.

    * Fresnel effect to enhance reflections at grazing angles.

    * Subsurface Scattering (SSS) to simulate light interaction within the water.

    * High Dynamic Range (HDR) for saturated and realistic lighting, especially from the sun.

## Inspirations and Resources

This project was heavily inspired by several resources. The initial idea was sparked by the following YouTube videos:

  * [Ocean waves simulation with Fast Fourier transform](http://www.youtube.com/watch?v=kGEqaX4Y4bQ)
  * [How Games Fake Water](http://www.youtube.com/watch?v=PH9q0HNBjT4)
  * [I Tried Simulating The Entire Ocean](http://www.youtube.com/watch?v=yPfagLeUa7k)

During development, which was completed over four days with limited prior C++ and OpenGL experience, the following repositories were used for inspiration and reference for some shader implementations:

  * [OceanFFT by achalpandeyy](https://github.com/achalpandeyy/OceanFFT)
  * [INF443 - Ocean FFT by czartur](https://github.com/czartur/ocean_fft)


## References

[1] Mihelich, M., & Tcheblokov, T. (2019). "Wakes, Explosions, and Lightning: Interactive Water Simulation in 'Atlas'". *Game Developers Conference (GDC)*.

[2] Tessendorf, J. (2004). "Simulating Ocean Water". *Proceedings of the 2004 ACM SIGGRAPH Course Notes*.