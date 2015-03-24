#!/usr/bin/env python

import subprocess



dlist = [3.5, 3.0, 2.5, 2.0, 1.0]

alist = [5, 10, 20, 30]

Ilist = [1500,2000,2500,3000]


for d in dlist:
    for a in alist:
        for I in Ilist:
            cmd = 'python.exe -u AblationLarge.py -d %f -a %f -I %f ' % (d, a, I)
            print(cmd)
            p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            for line in iter(p.stdout.readline, b''):
                print( line.rstrip())
    

    
