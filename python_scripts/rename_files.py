#!/usr/bin/env python

from os import listdir, rename

for file in listdir('/Users/aheggert/Desktop/export'):
    fn = file.replace('txt', 'md').replace('Notes', '')
    rename(f"/Users/aheggert/Desktop/export/{file}", f"/Users/aheggert/Desktop/export/{fn}")
