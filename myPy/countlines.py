#!/usr/bin/env python3

def countlines(fobj):
    p=fobj.tell()
    n=0
    n += sum(1 for line in fobj)
    fobj.seek(p)
    return n