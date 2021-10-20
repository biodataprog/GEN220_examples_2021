#!/usr/bin/env python3

import sys # this tells python we need to use a package called sys
i=0
for line in sys.stdin:
    print("line[%d] is %s"%(i,line),
          end = '')
    i +=1
    
print("there were",i,"lines")