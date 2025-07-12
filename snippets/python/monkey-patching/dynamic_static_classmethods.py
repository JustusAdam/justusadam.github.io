#! /usr/bin/env python3

class TestClass:
    pass


def foo():
    print('foo is executing')

def bar(cls):
    print('bar is executing')
    print(cls)


TestClass.static_foo = staticmethod(foo)

TestClass.class_bar = classmethod(bar)


TestClass.static_foo()
# =>> foo is executing

TestClass.class_bar()
# =>> bar is executing
# =>> <class '__main__.TestClass'>
