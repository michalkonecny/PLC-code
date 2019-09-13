import sys # needed for IO

def printA():
    print a # using a global variable before its declaration
            # OK because python variables are non-linearly scoped

def setA():
    # print a # ERROR - using local variable before initialisation
    # print b # ERROR - global name 'b' is not defined
    a = 2 # declaring a local variable

def tryPrintA():
    a = 3 # declaring a local variable
    printA() # printing the global a, not the one above

print "test1"
setA()
# print a # ERROR - variable "a" local to setA
# printA() # ERROR - global name 'a' is not defined

print "test2"
# tryPrintA() # ERROR - global name 'a' is not defined

print "test3"
a = 1
printA() # prints 1

print "test4"
tryPrintA() # prints 1, not 3

print "test5"
setA() # no effect (variable "a" in setA is local)
print a # prints 1
