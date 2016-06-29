# System imports
from distutils.core import setup, Extension

# Third-party modules - we depend on numpy for everything
import numpy

# Obtain the numpy include directory.  This logic works across numpy versions.
try:
    numpy_include = numpy.get_include()
except AttributeError:
    numpy_include = numpy.get_numpy_include()

# ezrange extension module
ezrange = Extension("_ezrange",
                   ["ezrange.i","ezrange.c"],
                   include_dirs = [numpy_include],
				   extra_compile_args = ["-fPIC", "-O2"]
                   )

# ezrange setup
setup(  name        = "range function",
        description = "range takes an integer and returns an n element int array where each element is equal to its index",
        author      = "Egor Zindy",
        version     = "1.0",
        ext_modules = [ezrange]
        )