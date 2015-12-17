
#ifndef BIOHEADGPUDEFS_H
#define BIOHEADGPUDEFS_H

#define FD_FIXEDVAL_BOUNDARYCOND 0
#define FD_FREEFLOW_BOUNDARYCOND 1


#define THREADS_PER_BLOCK 512


#include <iostream>

template<typename pbhe_t>
class pbhe_gpu_algorithm_session {

	public:
	int dev;
	int nx, ny, nz, nt;
	size_t typeSize;
	pbhe_t * temp3D_tf_dev, *temp3D_ti_dev, *tdot3D_dev, *kt3D_dev, *rhoCp3D_dev, *tmp, *Dtxyz_d;

	int initlevel;

	static pbhe_gpu_algorithm_session<pbhe_t> * GetInstance();
	void DestroyInstance() {
		delete pbhe_gpu_algorithm_session<pbhe_t>::the_instance;
		pbhe_gpu_algorithm_session<pbhe_t>::the_instance = NULL;
		pbhe_gpu_algorithm_session<pbhe_t>::exists = 0;
	};

protected:
	static pbhe_gpu_algorithm_session<pbhe_t> * the_instance;

private:
	static bool exists;

	pbhe_gpu_algorithm_session(){
		initlevel = 0;
		
		std::cout << "New singleton instance of type (#bits) " << 8*sizeof(pbhe_t) << std::endl;
	};
	
};

template<typename pbhe_t> bool pbhe_gpu_algorithm_session<pbhe_t>::exists = false;
template<typename pbhe_t> pbhe_gpu_algorithm_session<pbhe_t> * pbhe_gpu_algorithm_session<pbhe_t>::the_instance = NULL;

template<typename pbhe_t>
pbhe_gpu_algorithm_session<pbhe_t> * pbhe_gpu_algorithm_session<pbhe_t>::GetInstance() {

	if (!pbhe_gpu_algorithm_session<pbhe_t>::exists) {
		pbhe_gpu_algorithm_session<pbhe_t>::exists = 1;
		pbhe_gpu_algorithm_session<pbhe_t>::the_instance = new pbhe_gpu_algorithm_session<pbhe_t>;
	}
	return the_instance;
};

int computeBlockDims(int nx, int ny, int nz, int * dimX, int * dimY);

int New_PBHE_GPUmem(int nt, int nx, int ny, int nz, pbhe_gpu_algorithm_session<double> ** session);
int New_PBHE_GPUmem(int nt, int nx, int ny, int nz, pbhe_gpu_algorithm_session<float> ** session);
int ResetGPUDevice(int dev = 0);

int Pennes_2ndOrder_GPU(double * temp4D, double * tdot3D, double * kt3D, double * rhoCp3D,
	double * Dtxyz, double Tblood, double perfRate,
	int nt,
	int nx, int ny, int nz, int bcMode = FD_FREEFLOW_BOUNDARYCOND, pbhe_gpu_algorithm_session<double> * session = NULL);

int Pennes_2ndOrder_GPU_f(float * temp4D, float * tdot3D, float * kt3D, float * rhoCp3D,
	float * Dtxyz, float Tblood, float perfRate,
	int nt,
	int nx, int ny, int nz, int bcMode = FD_FREEFLOW_BOUNDARYCOND, pbhe_gpu_algorithm_session<float> * session = NULL);


#endif