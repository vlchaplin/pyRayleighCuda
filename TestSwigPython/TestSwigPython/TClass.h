template<class T>
class TClass {
	T xx;
	public:
	TClass() {xx=0;};
	~TClass() {};
	T plus(T num) {xx+=num; return xx;};
};
