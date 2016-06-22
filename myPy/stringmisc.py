# -*- coding: utf-8 -*-
"""
Created on Wed Jun 15 09:12:47 2016

@author: vlchaplin@gmail.com
"""


def longest_common_substring(s1, s2):
    """
    """
    #from https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Longest_common_substring
    m = [[0] * (1 + len(s2)) for i in range(1 + len(s1))]
    longest, x_longest = 0, 0
    for x in range(1, 1 + len(s1)):
        for y in range(1, 1 + len(s2)):
            if s1[x - 1] == s2[y - 1]:
                m[x][y] = m[x - 1][y - 1] + 1
                if m[x][y] > longest:
                    longest = m[x][y]
                    x_longest = x
            else:
                m[x][y] = 0
    return s1[x_longest - longest: x_longest]