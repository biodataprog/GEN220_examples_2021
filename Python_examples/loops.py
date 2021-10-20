#!/usr/bin/env python3

x=6

if x > 5:
    print("x is greater than 5; x is",x)
    print("this is another message")
    
    
x=10
y=10
if x == 10:
    print("this == 10")
if x == "10":
    print("this == '10'")
if x is 10:
    print("this is a 10")
if x is "10":
    print("This is '10'")
        

x="apple"
y="apple"
if x == y:
    print("x=y")
if x is y:
    print("x is y")
    
    
a=50
if a > 100:
    print("big number")
elif a > 10:
    print("medium number")
else:
    print("small number")