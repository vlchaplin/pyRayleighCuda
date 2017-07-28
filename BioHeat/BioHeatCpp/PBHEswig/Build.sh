
export NUMPYINC=/usr/local/lib/python3.5/dist-packages/numpy/core/include

CXXFLAGS+="-O2 -Wall -fPIC -std=c++11" 

swig -c++ -python -py3 -modern -I$NUMPYINC -I"../BioHeatCpp" -o "./PBHEswig_wrap.cpp" PBHEswig.i

PYINC=`python3-config --cflags`

g++ -c $CXXFLAGS $PYINC -I$NUMPYINC -I"../BioHeatCpp" PBHEswig_wrap.cpp
g++ -c $CXXFLAGS $PYINC -I$NUMPYINC -I"../BioHeatCpp" PBHEswig.cpp -o PBHEswig.o

PYFLAGS=`python3-config --ldflags`

#PYFLAGS="-L/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu -L/usr/lib -lpython3.5m -lpthread -ldl  -lutil -lm"

g++ -shared PBHEswig_wrap.o PBHEswig.o $PYFLAGS -o _PBHEswig.pyd

mv _PBHEswig.pyd PBHEswig.py custom
