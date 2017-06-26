# This file was automatically generated by SWIG (http://www.swig.org).
# Version 3.0.7
#
# Do not make changes to this file unless you know what you are doing--modify
# the SWIG interface file instead.





from sys import version_info
if version_info >= (2, 6, 0):
    def swig_import_helper():
        from os.path import dirname
        import imp
        fp = None
        try:
            fp, pathname, description = imp.find_module('_PBHEswig', [dirname(__file__)])
        except ImportError:
            import _PBHEswig
            return _PBHEswig
        if fp is not None:
            try:
                _mod = imp.load_module('_PBHEswig', fp, pathname, description)
            finally:
                fp.close()
            return _mod
    _PBHEswig = swig_import_helper()
    del swig_import_helper
else:
    import _PBHEswig
del version_info
try:
    _swig_property = property
except NameError:
    pass  # Python < 2.2 doesn't have 'property'.


def _swig_setattr_nondynamic(self, class_type, name, value, static=1):
    if (name == "thisown"):
        return self.this.own(value)
    if (name == "this"):
        if type(value).__name__ == 'SwigPyObject':
            self.__dict__[name] = value
            return
    method = class_type.__swig_setmethods__.get(name, None)
    if method:
        return method(self, value)
    if (not static):
        if _newclass:
            object.__setattr__(self, name, value)
        else:
            self.__dict__[name] = value
    else:
        raise AttributeError("You cannot add attributes to %s" % self)


def _swig_setattr(self, class_type, name, value):
    return _swig_setattr_nondynamic(self, class_type, name, value, 0)


def _swig_getattr_nondynamic(self, class_type, name, static=1):
    if (name == "thisown"):
        return self.this.own()
    method = class_type.__swig_getmethods__.get(name, None)
    if method:
        return method(self)
    if (not static):
        return object.__getattr__(self, name)
    else:
        raise AttributeError(name)

def _swig_getattr(self, class_type, name):
    return _swig_getattr_nondynamic(self, class_type, name, 0)


def _swig_repr(self):
    try:
        strthis = "proxy of " + self.this.__repr__()
    except:
        strthis = ""
    return "<%s.%s; %s >" % (self.__class__.__module__, self.__class__.__name__, strthis,)

try:
    _object = object
    _newclass = 1
except AttributeError:
    class _object:
        pass
    _newclass = 0


class mesh1d_f(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh1d_f, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, mesh1d_f, name)
    __repr__ = _swig_repr
    __swig_setmethods__["d"] = _PBHEswig.mesh1d_f_d_set
    __swig_getmethods__["d"] = _PBHEswig.mesh1d_f_d_get
    if _newclass:
        d = _swig_property(_PBHEswig.mesh1d_f_d_get, _PBHEswig.mesh1d_f_d_set)
    __swig_setmethods__["ds"] = _PBHEswig.mesh1d_f_ds_set
    __swig_getmethods__["ds"] = _PBHEswig.mesh1d_f_ds_get
    if _newclass:
        ds = _swig_property(_PBHEswig.mesh1d_f_ds_get, _PBHEswig.mesh1d_f_ds_set)
    __swig_setmethods__["data"] = _PBHEswig.mesh1d_f_data_set
    __swig_getmethods__["data"] = _PBHEswig.mesh1d_f_data_get
    if _newclass:
        data = _swig_property(_PBHEswig.mesh1d_f_data_get, _PBHEswig.mesh1d_f_data_set)
    __swig_setmethods__["scalar"] = _PBHEswig.mesh1d_f_scalar_set
    __swig_getmethods__["scalar"] = _PBHEswig.mesh1d_f_scalar_get
    if _newclass:
        scalar = _swig_property(_PBHEswig.mesh1d_f_scalar_get, _PBHEswig.mesh1d_f_scalar_set)
    __swig_setmethods__["ndims"] = _PBHEswig.mesh1d_f_ndims_set
    __swig_getmethods__["ndims"] = _PBHEswig.mesh1d_f_ndims_get
    if _newclass:
        ndims = _swig_property(_PBHEswig.mesh1d_f_ndims_get, _PBHEswig.mesh1d_f_ndims_set)
    __swig_setmethods__["usesSharedData"] = _PBHEswig.mesh1d_f_usesSharedData_set
    __swig_getmethods__["usesSharedData"] = _PBHEswig.mesh1d_f_usesSharedData_get
    if _newclass:
        usesSharedData = _swig_property(_PBHEswig.mesh1d_f_usesSharedData_get, _PBHEswig.mesh1d_f_usesSharedData_set)

    def __init__(self, *args):
        this = _PBHEswig.new_mesh1d_f(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh1d_f
    __del__ = lambda self: None

    def setndims(self, num):
        return _PBHEswig.mesh1d_f_setndims(self, num)

    def setdims(self, dims):
        return _PBHEswig.mesh1d_f_setdims(self, dims)
    __swig_setmethods__["isRowMaj"] = _PBHEswig.mesh1d_f_isRowMaj_set
    __swig_getmethods__["isRowMaj"] = _PBHEswig.mesh1d_f_isRowMaj_get
    if _newclass:
        isRowMaj = _swig_property(_PBHEswig.mesh1d_f_isRowMaj_get, _PBHEswig.mesh1d_f_isRowMaj_set)

    def getndims(self):
        return _PBHEswig.mesh1d_f_getndims(self)

    def getdims(self, dims):
        return _PBHEswig.mesh1d_f_getdims(self, dims)

    def setres(self, dres):
        return _PBHEswig.mesh1d_f_setres(self, dres)

    def getres(self, dres):
        return _PBHEswig.mesh1d_f_getres(self, dres)

    def clear(self):
        return _PBHEswig.mesh1d_f_clear(self)

    def setToScalar(self, value):
        return _PBHEswig.mesh1d_f_setToScalar(self, value)

    def useSharedData(self, dims, ptr2meshdata, resolution):
        return _PBHEswig.mesh1d_f_useSharedData(self, dims, ptr2meshdata, resolution)

    def val(self, idx):
        return _PBHEswig.mesh1d_f_val(self, idx)
mesh1d_f_swigregister = _PBHEswig.mesh1d_f_swigregister
mesh1d_f_swigregister(mesh1d_f)

class mesh3d_f(mesh1d_f):
    __swig_setmethods__ = {}
    for _s in [mesh1d_f]:
        __swig_setmethods__.update(getattr(_s, '__swig_setmethods__', {}))
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh3d_f, name, value)
    __swig_getmethods__ = {}
    for _s in [mesh1d_f]:
        __swig_getmethods__.update(getattr(_s, '__swig_getmethods__', {}))
    __getattr__ = lambda self, name: _swig_getattr(self, mesh3d_f, name)
    __repr__ = _swig_repr

    def __init__(self, *args):
        this = _PBHEswig.new_mesh3d_f(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh3d_f
    __del__ = lambda self: None

    def index(self, *args):
        return _PBHEswig.mesh3d_f_index(self, *args)

    def val(self, *args):
        return _PBHEswig.mesh3d_f_val(self, *args)

    def __call__(self, i0, i1, i2):
        return _PBHEswig.mesh3d_f___call__(self, i0, i1, i2)

    def getval(self, i0, i1, i2):
        return _PBHEswig.mesh3d_f_getval(self, i0, i1, i2)

    def setval(self, val, i0, i1, i2):
        return _PBHEswig.mesh3d_f_setval(self, val, i0, i1, i2)
mesh3d_f_swigregister = _PBHEswig.mesh3d_f_swigregister
mesh3d_f_swigregister(mesh3d_f)

class mesh4d_f(mesh1d_f):
    __swig_setmethods__ = {}
    for _s in [mesh1d_f]:
        __swig_setmethods__.update(getattr(_s, '__swig_setmethods__', {}))
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh4d_f, name, value)
    __swig_getmethods__ = {}
    for _s in [mesh1d_f]:
        __swig_getmethods__.update(getattr(_s, '__swig_getmethods__', {}))
    __getattr__ = lambda self, name: _swig_getattr(self, mesh4d_f, name)
    __repr__ = _swig_repr

    def __init__(self, *args):
        this = _PBHEswig.new_mesh4d_f(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh4d_f
    __del__ = lambda self: None

    def index(self, *args):
        return _PBHEswig.mesh4d_f_index(self, *args)

    def val(self, *args):
        return _PBHEswig.mesh4d_f_val(self, *args)

    def __call__(self, i0, i1, i2, i3):
        return _PBHEswig.mesh4d_f___call__(self, i0, i1, i2, i3)

    def getval(self, i0, i1, i2, i3):
        return _PBHEswig.mesh4d_f_getval(self, i0, i1, i2, i3)

    def setval(self, val, i0, i1, i2, i3):
        return _PBHEswig.mesh4d_f_setval(self, val, i0, i1, i2, i3)

    def getpage(self, i0):
        return _PBHEswig.mesh4d_f_getpage(self, i0)
mesh4d_f_swigregister = _PBHEswig.mesh4d_f_swigregister
mesh4d_f_swigregister(mesh4d_f)

class mesh34d_f(mesh4d_f):
    __swig_setmethods__ = {}
    for _s in [mesh4d_f]:
        __swig_setmethods__.update(getattr(_s, '__swig_setmethods__', {}))
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh34d_f, name, value)
    __swig_getmethods__ = {}
    for _s in [mesh4d_f]:
        __swig_getmethods__.update(getattr(_s, '__swig_getmethods__', {}))
    __getattr__ = lambda self, name: _swig_getattr(self, mesh34d_f, name)
    __repr__ = _swig_repr

    def __init__(self, *args):
        this = _PBHEswig.new_mesh34d_f(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh34d_f
    __del__ = lambda self: None

    def index(self, *args):
        return _PBHEswig.mesh34d_f_index(self, *args)

    def val(self, idx):
        return _PBHEswig.mesh34d_f_val(self, idx)
mesh34d_f_swigregister = _PBHEswig.mesh34d_f_swigregister
mesh34d_f_swigregister(mesh34d_f)

class mesh1d(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh1d, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, mesh1d, name)
    __repr__ = _swig_repr
    __swig_setmethods__["d"] = _PBHEswig.mesh1d_d_set
    __swig_getmethods__["d"] = _PBHEswig.mesh1d_d_get
    if _newclass:
        d = _swig_property(_PBHEswig.mesh1d_d_get, _PBHEswig.mesh1d_d_set)
    __swig_setmethods__["ds"] = _PBHEswig.mesh1d_ds_set
    __swig_getmethods__["ds"] = _PBHEswig.mesh1d_ds_get
    if _newclass:
        ds = _swig_property(_PBHEswig.mesh1d_ds_get, _PBHEswig.mesh1d_ds_set)
    __swig_setmethods__["data"] = _PBHEswig.mesh1d_data_set
    __swig_getmethods__["data"] = _PBHEswig.mesh1d_data_get
    if _newclass:
        data = _swig_property(_PBHEswig.mesh1d_data_get, _PBHEswig.mesh1d_data_set)
    __swig_setmethods__["scalar"] = _PBHEswig.mesh1d_scalar_set
    __swig_getmethods__["scalar"] = _PBHEswig.mesh1d_scalar_get
    if _newclass:
        scalar = _swig_property(_PBHEswig.mesh1d_scalar_get, _PBHEswig.mesh1d_scalar_set)
    __swig_setmethods__["ndims"] = _PBHEswig.mesh1d_ndims_set
    __swig_getmethods__["ndims"] = _PBHEswig.mesh1d_ndims_get
    if _newclass:
        ndims = _swig_property(_PBHEswig.mesh1d_ndims_get, _PBHEswig.mesh1d_ndims_set)
    __swig_setmethods__["usesSharedData"] = _PBHEswig.mesh1d_usesSharedData_set
    __swig_getmethods__["usesSharedData"] = _PBHEswig.mesh1d_usesSharedData_get
    if _newclass:
        usesSharedData = _swig_property(_PBHEswig.mesh1d_usesSharedData_get, _PBHEswig.mesh1d_usesSharedData_set)

    def __init__(self, *args):
        this = _PBHEswig.new_mesh1d(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh1d
    __del__ = lambda self: None

    def setndims(self, num):
        return _PBHEswig.mesh1d_setndims(self, num)

    def setdims(self, dims):
        return _PBHEswig.mesh1d_setdims(self, dims)
    __swig_setmethods__["isRowMaj"] = _PBHEswig.mesh1d_isRowMaj_set
    __swig_getmethods__["isRowMaj"] = _PBHEswig.mesh1d_isRowMaj_get
    if _newclass:
        isRowMaj = _swig_property(_PBHEswig.mesh1d_isRowMaj_get, _PBHEswig.mesh1d_isRowMaj_set)

    def getndims(self):
        return _PBHEswig.mesh1d_getndims(self)

    def getdims(self, dims):
        return _PBHEswig.mesh1d_getdims(self, dims)

    def setres(self, dres):
        return _PBHEswig.mesh1d_setres(self, dres)

    def getres(self, dres):
        return _PBHEswig.mesh1d_getres(self, dres)

    def clear(self):
        return _PBHEswig.mesh1d_clear(self)

    def setToScalar(self, value):
        return _PBHEswig.mesh1d_setToScalar(self, value)

    def useSharedData(self, dims, ptr2meshdata, resolution):
        return _PBHEswig.mesh1d_useSharedData(self, dims, ptr2meshdata, resolution)

    def val(self, idx):
        return _PBHEswig.mesh1d_val(self, idx)
mesh1d_swigregister = _PBHEswig.mesh1d_swigregister
mesh1d_swigregister(mesh1d)

class mesh3d(mesh1d):
    __swig_setmethods__ = {}
    for _s in [mesh1d]:
        __swig_setmethods__.update(getattr(_s, '__swig_setmethods__', {}))
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh3d, name, value)
    __swig_getmethods__ = {}
    for _s in [mesh1d]:
        __swig_getmethods__.update(getattr(_s, '__swig_getmethods__', {}))
    __getattr__ = lambda self, name: _swig_getattr(self, mesh3d, name)
    __repr__ = _swig_repr

    def __init__(self, *args):
        this = _PBHEswig.new_mesh3d(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh3d
    __del__ = lambda self: None

    def index(self, *args):
        return _PBHEswig.mesh3d_index(self, *args)

    def val(self, *args):
        return _PBHEswig.mesh3d_val(self, *args)

    def __call__(self, i0, i1, i2):
        return _PBHEswig.mesh3d___call__(self, i0, i1, i2)

    def getval(self, i0, i1, i2):
        return _PBHEswig.mesh3d_getval(self, i0, i1, i2)

    def setval(self, val, i0, i1, i2):
        return _PBHEswig.mesh3d_setval(self, val, i0, i1, i2)
mesh3d_swigregister = _PBHEswig.mesh3d_swigregister
mesh3d_swigregister(mesh3d)

class mesh4d(mesh1d):
    __swig_setmethods__ = {}
    for _s in [mesh1d]:
        __swig_setmethods__.update(getattr(_s, '__swig_setmethods__', {}))
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh4d, name, value)
    __swig_getmethods__ = {}
    for _s in [mesh1d]:
        __swig_getmethods__.update(getattr(_s, '__swig_getmethods__', {}))
    __getattr__ = lambda self, name: _swig_getattr(self, mesh4d, name)
    __repr__ = _swig_repr

    def __init__(self, *args):
        this = _PBHEswig.new_mesh4d(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh4d
    __del__ = lambda self: None

    def index(self, *args):
        return _PBHEswig.mesh4d_index(self, *args)

    def val(self, *args):
        return _PBHEswig.mesh4d_val(self, *args)

    def __call__(self, i0, i1, i2, i3):
        return _PBHEswig.mesh4d___call__(self, i0, i1, i2, i3)

    def getval(self, i0, i1, i2, i3):
        return _PBHEswig.mesh4d_getval(self, i0, i1, i2, i3)

    def setval(self, val, i0, i1, i2, i3):
        return _PBHEswig.mesh4d_setval(self, val, i0, i1, i2, i3)

    def getpage(self, i0):
        return _PBHEswig.mesh4d_getpage(self, i0)
mesh4d_swigregister = _PBHEswig.mesh4d_swigregister
mesh4d_swigregister(mesh4d)

class mesh34d(mesh4d):
    __swig_setmethods__ = {}
    for _s in [mesh4d]:
        __swig_setmethods__.update(getattr(_s, '__swig_setmethods__', {}))
    __setattr__ = lambda self, name, value: _swig_setattr(self, mesh34d, name, value)
    __swig_getmethods__ = {}
    for _s in [mesh4d]:
        __swig_getmethods__.update(getattr(_s, '__swig_getmethods__', {}))
    __getattr__ = lambda self, name: _swig_getattr(self, mesh34d, name)
    __repr__ = _swig_repr

    def __init__(self, *args):
        this = _PBHEswig.new_mesh34d(*args)
        try:
            self.this.append(this)
        except:
            self.this = this
    __swig_destroy__ = _PBHEswig.delete_mesh34d
    __del__ = lambda self: None

    def index(self, *args):
        return _PBHEswig.mesh34d_index(self, *args)

    def val(self, idx):
        return _PBHEswig.mesh34d_val(self, idx)
mesh34d_swigregister = _PBHEswig.mesh34d_swigregister
mesh34d_swigregister(mesh34d)


def test1int(invec):
    return _PBHEswig.test1int(invec)
test1int = _PBHEswig.test1int

def testintarr(invec):
    return _PBHEswig.testintarr(invec)
testintarr = _PBHEswig.testintarr

def pbheSolve_f(useFreeflow, dt, dx, dy, dz, T, Tdot_source, kt0, rho_Cp, Tblood, perfusionrate, ta_i=0, tb_i=-1):
    """
    pbheSolve_f(freeFlow, dt,dx,dy,dz, mesh4d_f T, mesh4d_f Tdot, mesh3d_f k, mesh3d_f rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T
    pbheSolve_f(freeFlow, dt,dx,dy,dz, mesh4d_f T, mesh4d_f Tdot, mesh3d_f k, mesh3d_f rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T
    pbheSolve_f(freeFlow, dt,dx,dy,dz, mesh4d_f T, mesh4d_f Tdot, mesh3d_f k, mesh3d_f rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T
    """
    return _PBHEswig.pbheSolve_f(useFreeflow, dt, dx, dy, dz, T, Tdot_source, kt0, rho_Cp, Tblood, perfusionrate, ta_i, tb_i)

def pbheSolve(useFreeflow, dt, dx, dy, dz, T, Tdot_source, kt0, rho_Cp, Tblood, perfusionrate, ta_i=0, tb_i=-1):
    """
    pbheSolve(freeFlow, dt,dx,dy,dz, mesh4d T, mesh4d Tdot, mesh3d k, mesh3d rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T
    pbheSolve(freeFlow, dt,dx,dy,dz, mesh4d T, mesh4d Tdot, mesh3d k, mesh3d rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T
    pbheSolve(freeFlow, dt,dx,dy,dz, mesh4d T, mesh4d Tdot, mesh3d k, mesh3d rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T
    """
    return _PBHEswig.pbheSolve(useFreeflow, dt, dx, dy, dz, T, Tdot_source, kt0, rho_Cp, Tblood, perfusionrate, ta_i, tb_i)

def ShareMemoryMesh3(IN_ARRAY3, res, infunc):
    return _PBHEswig.ShareMemoryMesh3(IN_ARRAY3, res, infunc)
ShareMemoryMesh3 = _PBHEswig.ShareMemoryMesh3

def ShareMemoryMesh34(IN_ARRAY3, res, infunc):
    return _PBHEswig.ShareMemoryMesh34(IN_ARRAY3, res, infunc)
ShareMemoryMesh34 = _PBHEswig.ShareMemoryMesh34

def ShareMemoryMesh4(IN_ARRAY4, res, infunc):
    return _PBHEswig.ShareMemoryMesh4(IN_ARRAY4, res, infunc)
ShareMemoryMesh4 = _PBHEswig.ShareMemoryMesh4

def ShareMemoryMesh3_f(IN_ARRAY3, res, infunc):
    return _PBHEswig.ShareMemoryMesh3_f(IN_ARRAY3, res, infunc)
ShareMemoryMesh3_f = _PBHEswig.ShareMemoryMesh3_f

def ShareMemoryMesh34_f(IN_ARRAY3, res, infunc):
    return _PBHEswig.ShareMemoryMesh34_f(IN_ARRAY3, res, infunc)
ShareMemoryMesh34_f = _PBHEswig.ShareMemoryMesh34_f

def ShareMemoryMesh4_f(IN_ARRAY4, res, infunc):
    return _PBHEswig.ShareMemoryMesh4_f(IN_ARRAY4, res, infunc)
ShareMemoryMesh4_f = _PBHEswig.ShareMemoryMesh4_f
# This file is compatible with both classic and new-style classes.

