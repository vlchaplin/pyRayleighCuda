

#ifndef MULTIDIMARRAYS_H
#define MULTIDIMARRAYS_H

#include <stdlib.h>

//Flat array access T * A = array2d[0]

template <class T> T **Create2D(int N1, int N2)
{
	T ** array = new T *[N1];

	array[0] = new T [N1*N2];
	int i;

	for (i = 0; i < N1; i++) {

		if (i < N1 - 1) {
			array[i + 1] = &(array[0][(i + 1)*N2]);
		}
	}

	return array;
};

template <class T> void Delete2D(T **array) {
	delete[] array[0];
	delete[] array;
};

//Flat array access T * A = array3d[0][0]
template <class T> T ***Create3D(int N1, int N2, int N3)
{
	T *** array = new T **[N1];

	array[0] = new T *[N1*N2];

	array[0][0] = new T[N1*N2*N3];

	int i, j;

	for (i = 0; i < N1; i++) {

		if (i < N1 - 1) {

			array[0][(i + 1)*N2] = &(array[0][0][(i + 1)*N3*N2]);

			array[i + 1] = &(array[0][(i + 1)*N2]);

		}

		for (j = 0; j < N2; j++) {
			if (j > 0) array[i][j] = array[i][j - 1] + N3;
		}

	}

	return array;
};

template <class T> void Delete3D(T ***array) {
	delete[] array[0][0];
	delete[] array[0];
	delete[] array;
};



#endif