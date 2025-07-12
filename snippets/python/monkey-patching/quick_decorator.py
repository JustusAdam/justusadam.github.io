#! /usr/bin/env python3

def my_decorator(func):
    return func


# ergo

@my_decorator
def function1():
    pass


# is equivalent to

def function1():
    pass

function1 = my_decorator(function1)
