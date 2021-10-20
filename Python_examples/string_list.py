#!/usr/bin/env python3

codestr="17,20,30,12,5,6,19,13"
# split it into an array
dat=codestr.split(",")
# print the first item
print(dat[0])
# print the sum of the 2nd and 3rd items
# this won't work because they are strings
#print(dat[1]+dat[2])
print(int(dat[1]) + int(dat[2]) )
# print the summation of the whole dataset
# this won't work because it is an array of strings
#print(sum(dat))
intarray = [ int(x) for x in dat]
print("total sum is: ",sum(intarray))

# make a new array from the 3rd and 6th columns
newarray=[dat[2],dat[5]]
# print the new array
print("the new array is ",newarray)

# make a new string from the array contents
# sort the array
intarraysort = sorted(intarray)
# convert items to a string and then join together
print(",".join([str(x) for x in intarraysort]))