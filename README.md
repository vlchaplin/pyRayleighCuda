# pyRayleighCuda
Vandiver Chaplin, vlchaplin@gmail.com

Python Rayleigh-Sommerfeld integral for acoustics, with optional CUDA GPU implementation. 

The primary API is accessed through the `transducers.py`. Add `pyRayleighCuda` to your python path and simply `import transducers`. It contains functions for computing narrow-band pressure fields in the Fourier domain, using inputs of array element positions/directions, frequency, element phases and amplitudes, and spatial grid points.

The `CUDA/RSgpu` directory contains all the code necessary for building the CUDA-accelerated pressure kernels. Please contact the author for support to build on your system. Basic requirements include the NVidia CUDA Toolkit compatible with your version of Python, and a compatible C++ compiler. Currently a Windows Visual Studio project was is present that was used to build for conda py35, Visuatl Studio 2017, CUDA Toolkit v8.0, but a more platform-independent build system is in the works.
